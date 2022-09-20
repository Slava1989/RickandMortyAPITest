//
//  CharacterInfo.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import Foundation

class CharacterResultModel: ResponseProtocol {
    let results: [CharacterInfo]
}

// MARK: - Result
class CharacterInfo: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var episodeName: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name, status, species, type
        case gender
        case origin, location
        case image
        case episode
        case url
        case created
    }
}

// MARK: - Location
class Location: Codable {
    let name: String
    let url: String
}
