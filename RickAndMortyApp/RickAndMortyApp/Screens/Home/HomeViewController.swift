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

    // MARK: Views

    private lazy var charactersTableView = UITableView()

    // MARK: Init

    override func viewDidLoad() {
        setup()
    }

    private func setup() {
        title = "Rick and Morty App"
        charactersTableView.register(
            CharacterCell.self,
            forCellReuseIdentifier: CharacterCell.identifier
        )

        view.addSubview(charactersTableView)

        charactersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public func bind(to viewModel: HomeViewModel) {
        viewModel.allCharacters
            .bind(to: charactersTableView.rx.items(
                    cellIdentifier: CharacterCell.identifier,
                    cellType: CharacterCell.self)
            ) { _, character, cell in
                cell.configure(withCharacter: character)
            }.disposed(by: disposer)

        charactersTableView.rx
            .modelSelected(CharacterKeyInfo.self)
            .map(\.id)
            .bind { [weak viewModel] charSelectedId in
                viewModel?.getDetails(forCharacterWithId: charSelectedId)
            }.disposed(by: disposer)
    }
}
