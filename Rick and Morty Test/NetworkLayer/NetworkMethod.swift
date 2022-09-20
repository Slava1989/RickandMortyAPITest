//
//  NetworkMethod.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import Foundation

enum NetworkMethod {
    static let baseURL = "https://rickandmortyapi.com/api/"

    case characters(String)
    case episodes(String)
    case locations(String)

    var url: URL? {
        switch self {
        case .characters(let page):
            var urlComponents = URLComponents(string: NetworkMethod.baseURL + "character")
            urlComponents?.queryItems = [
                 URLQueryItem(name: "page", value: page)
            ]
            return urlComponents?.url
        case .episodes(let page):
            var urlComponents = URLComponents(string: NetworkMethod.baseURL + "episode")
            urlComponents?.queryItems = [
                 URLQueryItem(name: "page", value: page)
            ]
            return urlComponents?.url
        case .locations(let locationName):
            var urlComponents = URLComponents(string: NetworkMethod.baseURL + "location")
            urlComponents?.queryItems = [
                 URLQueryItem(name: "name", value: "\(locationName)")
            ]

            return urlComponents?.url
        }


    }
}

