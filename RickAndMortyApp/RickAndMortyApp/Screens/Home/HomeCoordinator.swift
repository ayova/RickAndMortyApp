//
//  HomeCoordinator.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case main
}

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    private let appRouter: WeakRouter<AppRoute>
    private lazy var vm = HomeViewModel(router: weakRouter)

    init(router: WeakRouter<AppRoute>) {
        self.appRouter = router
        let screen = HomeViewController()
        super.init(rootViewController: .init(rootViewController: screen))
        screen.bind(to: vm)
    }

    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .main:
            return .none()
        }
    }
}