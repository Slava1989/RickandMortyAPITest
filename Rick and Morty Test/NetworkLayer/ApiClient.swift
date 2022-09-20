//
//  ApiClient.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchCharacters<T: ResponseProtocol>(method: NetworkMethod, completed: @escaping (T?, NetworkError?) -> Void)
}

class ServiceAPI {
    static let shared: ServiceAPIProtocol = ServiceAPI()
    private init() { }
}

extension ServiceAPI: ServiceAPIProtocol {

    func fetchCharacters<T: ResponseProtocol>(method: NetworkMethod, completed: @escaping (T?, NetworkError?) -> Void) {
        switch method {
        case .characters(let page):
            guard let url = NetworkMethod.characters(page).url else {
                return
            }
            executeAPICall(url, completed)
        case .episodes(let page):
            guard let url = NetworkMethod.episodes(page).url else {
                return
            }
            executeAPICall(url, completed)
        case .locations(let page):
            guard let url = NetworkMethod.locations(page).url else {
                return
            }
            executeAPICall(url, completed)
        }

    }

    fileprivate func executeAPICall<T: ResponseProtocol>(_ url: URL, _ completed: @escaping (T?, NetworkError?) -> Void) {
        URLSession.shared
            .dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completed(nil, NetworkError.serverError)
                    return
                }

                switch httpResponse.statusCode {
                case 200:
                    do {
                        guard let data = data else {
                            completed(nil, NetworkError.serverError)
                            return
                        }

                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completed(decodedData, nil)
                    } catch {

                    }
                case 400:
                    print("OOps")
                case 500:
                    completed(nil, NetworkError.serverError)
                default:
                    completed(nil, NetworkError.serverError)
                }
            }
            .resume()
    }
}


