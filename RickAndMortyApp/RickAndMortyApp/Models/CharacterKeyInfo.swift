//
//  CharacterInfo.swift
//  RickAndMortyApp
//
//  Created by Agustin Ovari on 5/7/21.
//

import Foundation

struct CharacterListResponse: Codable {
    let info: CharactersResponseHeaders
    let results: [CharacterKeyInfo]
}

struct CharactersResponseHeaders: Codable {
    let count: Int
    let next: String
}

struct CharacterKeyInfo: Codable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let image: String
}

struct CharacterDetails: Codable {
    let id : Int
    let name, status, species, type, gender, image : String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let episode : [String]
}

struct CharacterOrigin: Codable {
    let name: String
}

struct CharacterLocation: Codable {
    let name: String
}
