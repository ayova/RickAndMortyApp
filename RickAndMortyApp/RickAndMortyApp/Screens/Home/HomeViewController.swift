//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import RxCocoa
import RxSwift
import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    private let disposer = DisposeBag()
    // TODO: tableView

    // MARK: Views

    // MARK: Init

    override func viewDidLoad() {
        setup()
    }

    private func setup() {
        view.backgroundColor = .red
        // TODO: lay out the tableView
    }

    public func bind(to viewModel: HomeViewModel) {
        // TODO: bind tableView & model selections
    }
}
