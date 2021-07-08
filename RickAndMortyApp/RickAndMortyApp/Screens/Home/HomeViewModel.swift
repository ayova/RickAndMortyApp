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
    private let disposer = DisposeBag()

    // MARK: Public properties

    public let totalCharCount = BehaviorRelay<Int?>(value: nil)
    public let allCharacters = BehaviorRelay<[CharacterKeyInfo]>(value: [])
    public let selectedCharacter = BehaviorRelay<CharacterDetails?>(value: nil)
    public let nextPage = BehaviorRelay<String?>(value: nil)

    // MARK: Init

    init(router: WeakRouter<HomeRoute>) {
        self.router = router
        super.init()
        setupRx()
    }

    private func setupRx() {
        selectedCharacter
            .bind { [weak self] selectedCharacter in
                if let character = selectedCharacter {
                    self?.openDetails(for: character)
                }
            }.disposed(by: disposer)
    }

    // MARK: Actions

    public func getCharacters() {
        AF.request(Constants.charactersUrl).response { [weak self] response in
            guard let response = response.data else { return }

            do {
                let data = try JSONDecoder().decode(CharacterListResponse.self, from: response)
                self?.allCharacters.accept(data.results)
                let info = data.info as CharactersResponseHeaders
                self?.totalCharCount.accept(info.count)
                self?.nextPage.accept(info.next)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }

    public func getMoreCharacters() {
        guard let nextPageUrl = nextPage.value else { return }
        AF.request(nextPageUrl).response { [weak self] response in
            guard let response = response.data else { return }

            do {
                let data = try JSONDecoder().decode(CharacterListResponse.self, from: response)
                // append new characters
                var appendingCharacters = self?.allCharacters.value
                appendingCharacters?.append(contentsOf: data.results)
                if let characters = appendingCharacters {
                    self?.allCharacters.accept(characters)
                }

                // set next page
                let info = data.info as CharactersResponseHeaders
                self?.nextPage.accept(info.next)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }

    public func getDetails(forCharacterWithId charId: Int) {
        AF.request(Constants.charactersUrl.appending(String(charId))).response { [weak self] response in
            guard let response = response.data else { return }

            do {
                let character = try JSONDecoder().decode(CharacterDetails.self, from: response)
                self?.selectedCharacter.accept(character)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }

    private func openDetails(for character: CharacterDetails) {
        router.trigger(.details(forCharacter: character))
    }
}

private enum Constants {
    static let charactersUrl = "https://rickandmortyapi.com/api/character/"
}
