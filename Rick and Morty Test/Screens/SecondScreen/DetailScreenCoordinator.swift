//
//  DetailScreenCoordinator.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 18.09.2022.
//

import UIKit

class DetailScreenCoordinator: Coordinator {
    var rootViewController: UINavigationController?

    var characters: [CharacterInfo]
    var selectedCharacter: CharacterInfo
    var episodeName: String

    init(rootViewController: UINavigationController?, characters: [CharacterInfo], selectedCharacter: CharacterInfo, episodeName: String) {
        self.rootViewController = rootViewController
        self.characters = characters
        self.selectedCharacter = selectedCharacter
        self.episodeName = episodeName
    }

    func start() {
        let detailViewModel = DetailScreenViewModel(coordinator: self, characters: characters)
        let detailVC = DetailScreenViewController(
            viewModel: detailViewModel,
            selectedCharacter: selectedCharacter
        )

        rootViewController?.pushViewController(detailVC, animated: true)
    }


}
