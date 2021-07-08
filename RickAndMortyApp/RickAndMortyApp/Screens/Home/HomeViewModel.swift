//
//  HomeViewModel.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift
import XCoordinator

final class HomeViewModel: NSObject {
    private let router: WeakRouter<HomeRoute>

    // MARK: Public properties

    public let allCharacters = BehaviorRelay<[CharacterInfo]>(value: [])

    init(router: WeakRouter<HomeRoute>) {
        self.router = router
        super.init()
    }

    public func getCharacters() {
        AF.request("https://rickandmortyapi.com/api/character/").response { [weak self] response in
            guard let response = response.data else { return }

            do {
                let data = try JSONDecoder().decode(CharacterListResponse.self, from: response)
                self?.allCharacters.accept(data.results)
                let info = data.info as CharactersResponseHeaders
                self?.totalCharCount.accept(info.totalCount)
                self?.nextPage.accept(info.next)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }


    public func goToMain() {
        router.trigger(.main)
    }
}
