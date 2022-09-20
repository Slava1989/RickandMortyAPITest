//
//  MainCoordinator.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var rootViewController: UINavigationController?
    var childCoordinator = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func start() {
        let mainViewModel = MainScreenViewModel(coordinator: self)
        let mainVC = MainScreenController(viewModel: mainViewModel)

        rootViewController?.setViewControllers([mainVC], animated: true)
    }

    func goToDetailScree(selectedCharacter: CharacterInfo, episodeName: String, characterArray: [CharacterInfo]) {
        let tableCoordinator = DetailScreenCoordinator(
            rootViewController: rootViewController,
            characters: characterArray,
            selectedCharacter: selectedCharacter,
            episodeName: episodeName
        )
        tableCoordinator.start()
    }
 }
