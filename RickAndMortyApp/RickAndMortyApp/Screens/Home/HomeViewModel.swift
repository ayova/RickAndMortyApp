//
//  HomeViewModel.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Alamofire
import Foundation
import XCoordinator

final class HomeViewModel: NSObject {
    private let router: WeakRouter<HomeRoute>

    init(router: WeakRouter<HomeRoute>) {
        self.router = router
        super.init()
    }

    public func goToMain() {
        router.trigger(.main)
    }
}
