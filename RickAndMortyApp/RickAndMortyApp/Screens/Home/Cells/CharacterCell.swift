//
//  CharacterDetailsCell.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 8/7/21.
//

import Kingfisher
import UIKit

final class CharacterCell: UITableViewCell {
    static let identifier = "CharacterCell"

    // MARK: Views

    private let nameLabel = UILabel()
    private let specieLabel = UILabel()
    private let statusLabel = UILabel()
    private let characterImageView = UIImageView()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        styleCell()
        [nameLabel, specieLabel, statusLabel, characterImageView].forEach { subview in
            view.addSubview(subview)
         }

        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }

        specieLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(specieLabel.snp.bottom).offset(8)
            make.leading.bottom.equalToSuperview().inset(16)
        }

        characterImageView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

    public func configure(withCharacter characterInfo: CharacterInfo) {
        nameLabel.text = characterInfo.name
        specieLabel.text = "Specie: ".appending(characterInfo.species)
        statusLabel.text = "Status: ".appending(characterInfo.status)

        if let imageUrl = URL(string: characterInfo.image) {
            characterImageView.kf.setImage(with: imageUrl)
        }
    }

    private func styleCell() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        specieLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.font = UIFont.systemFont(ofSize: 14)

        self.characterImageView.layer.cornerRadius = 20
        self.characterImageView.layer.masksToBounds = true
    }
}
