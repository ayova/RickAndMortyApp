//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Foundation
import XCoordinator
import RxSwift
import UIKit

enum AppRoute: Route {
    case main
}

final class AppCoordinator: ViewCoordinator<AppRoute> {
    private let disposer = DisposeBag()

    init() {
        super.init(rootViewController: UIViewController())
        trigger(.main)
    }

    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {
        case .main:
            let coord = HomeCoordinator(router: weakRouter)
            return .embed(coord, in: viewController)
        }
    }

}

extension Transition {
    public static func switchTo(_ presentable: Presentable, in container: Container) -> Self {
        for child in container.viewController.children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        return embed(presentable, in: container)
    }
}
