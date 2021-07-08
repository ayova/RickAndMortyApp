//
//  CharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 8/7/21.
//

import Foundation
import UIKit

final class CharacterDetailViewController: UIViewController {

    // MARK: Views

    // Structure
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let dataStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16

        return stack
    }()

    // Data
    private let specieLabel = UILabel()
    private let statusLabel = UILabel()
    private let typeLabel = UILabel()
    private let genderLabel = UILabel()
    private let originLabel = UILabel()
    private let locationLabel = UILabel()
    private let characterImageView = UIImageView()

    // MARK: Init

    init(for character: CharacterDetails) {
        super.init(nibName: nil, bundle: nil)
        setup(character)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(_ character: CharacterDetails) {
        view.backgroundColor = .white
        title = character.name

        // Populate views
        specieLabel.text = character.species
        statusLabel.text = character.status
        typeLabel.text = character.type
        genderLabel.text = character.gender
        originLabel.text = character.origin.name
        locationLabel.text = character.location.name
        if let imageUrl = URL(string: character.image) {
            characterImageView.kf.setImage(with: imageUrl)
            characterImageView.contentMode = .scaleToFill
        }

        // Add views
        [specieLabel, statusLabel, typeLabel, genderLabel,
         originLabel, locationLabel, characterImageView].forEach { subview in
            dataStack.addArrangedSubview(subview)
         }

        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(dataStack)
        scrollContentView.addSubview(characterImageView)

        // Arrange views
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
            make.height.greaterThanOrEqualToSuperview()
        }

        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }

        dataStack.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
