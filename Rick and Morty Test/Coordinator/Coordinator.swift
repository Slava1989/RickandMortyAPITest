//
//  Coordinator.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UINavigationController? { get set }
    func start()
}
