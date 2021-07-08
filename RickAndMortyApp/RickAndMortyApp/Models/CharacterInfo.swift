//
//  CharacterInfo.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Foundation

struct CharacterListResponse: Codable {
    let info: CharactersResponseHeaders
    let results: [CharacterInfo]
}

struct CharactersResponseHeaders: Codable {
    let totalCount: Int
    let next: String

    enum CharInfoKeys: String, CodingKey {
        case totalCount = "count"
        case next
    }
}

struct CharacterInfo: Codable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let image: String
}
