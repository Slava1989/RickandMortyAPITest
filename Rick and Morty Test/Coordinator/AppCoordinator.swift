//
//  MainCoordinator.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var rootViewController: UINavigationController?

    var childCoordinators = [Coordinator]()
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        rootViewController = nil
    }

    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
}
