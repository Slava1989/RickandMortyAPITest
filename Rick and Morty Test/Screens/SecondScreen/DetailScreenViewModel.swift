//
//  DetailScreenViewModel.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 18.09.2022.
//

import Foundation

protocol DetailScreenProtocol: AnyObject {
    func filterCharacters(selectedCharacter: CharacterInfo) -> [CharacterInfo]
}

class DetailScreenViewModel {
    var coordinator: DetailScreenCoordinator
    var characters: [CharacterInfo]

    init(coordinator: DetailScreenCoordinator, characters: [CharacterInfo]) {
        self.coordinator = coordinator
        self.characters = characters
    }
}

extension DetailScreenViewModel: DetailScreenProtocol {
    func filterCharacters(selectedCharacter: CharacterInfo) -> [CharacterInfo] {
        characters.filter { character in
            return character.id != selectedCharacter.id && character.episodeName == selectedCharacter.episodeName
        }
    }
}
