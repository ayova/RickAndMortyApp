//
//  HomeCoordinator.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case details(forCharacter: CharacterDetails)
}

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    private let appRouter: WeakRouter<AppRoute>
    private lazy var homeViewModel = HomeViewModel(router: weakRouter)

    init(router: WeakRouter<AppRoute>) {
        self.appRouter = router
        let screen = HomeViewController()
        super.init(rootViewController: .init(rootViewController: screen))
        homeViewModel.getCharacters()
        screen.bind(to: homeViewModel)
    }

    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .details(let character):
            let vc = CharacterDetailViewController(for: character)
            return .push(vc)
        }
    }
}
