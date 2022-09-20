//
//  EpisodeInfo.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 17.09.2022.
//

import Foundation

struct EpisodeResultModel: ResponseProtocol {
    let info: Info
    let results: [EpisodeResult]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct EpisodeResult: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
