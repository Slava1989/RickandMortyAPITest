//
//  NetworkError.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import Foundation

enum NetworkError: Error {
    case serverError

    var errorDescription: String {
        switch self {
        case .serverError: return "Произошла ошибка на сервере"
        }
    }
}
