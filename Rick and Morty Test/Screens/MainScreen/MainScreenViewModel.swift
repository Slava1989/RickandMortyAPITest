//
//  MainScreenViewModel.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit

protocol MainScreenProtocol: AnyObject {
    func fetchCharacters(completed: @escaping ([CharacterInfo]?, String?) -> Void)
    func fetchEpisodes(completed: @escaping ([EpisodeResult]?, String?) -> Void)
    func getEpisode(by characterURL: String) -> EpisodeResult?
    func moveToDetailScreen(selectedCharacter: CharacterInfo, episodeName: String, characterArray: [CharacterInfo])
    func fetchEpisodes(charactersInfo: [CharacterInfo])
}

final class MainScreenViewModel {
    var coordinator: MainCoordinator
    var episodesInfo: [EpisodeResult]? = []
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    private func mergeEpisodeAndCharacters(charactersInfo: [CharacterInfo]) {
        for character in charactersInfo {
            character.episodeName = getEpisode(by: character.episode[0])?.name ?? ""
        }
    }
}

extension MainScreenViewModel: MainScreenProtocol {
    func moveToDetailScreen(selectedCharacter: CharacterInfo, episodeName: String, characterArray: [CharacterInfo]) {
        coordinator.goToDetailScree(selectedCharacter: selectedCharacter, episodeName: episodeName, characterArray: characterArray)
    }

    func getEpisode(by characterURL: String) -> EpisodeResult? {
        let urlID = characterURL.split(separator: "/").last ?? ""
        let episode = episodesInfo?.first(where: { result in
            return result.id == Int(urlID)
        })

        return episode
    }

    func fetchEpisodes(completed: @escaping ([EpisodeResult]?, String?) -> Void) {
        (1...3).forEach { pageNumber in
            ServiceAPI.shared.fetchCharacters(method: .episodes("\(pageNumber)")) { [weak self] (resultModel: EpisodeResultModel?, networkError: NetworkError?) in
                if networkError != nil {
                    DispatchQueue.main.async {
                        completed(nil, networkError?.errorDescription)
                    }

                    return
                }

                DispatchQueue.main.async {
                    guard let resultModel = resultModel
                    else {
                        completed(nil, networkError?.errorDescription)
                        return
                    }

                    self?.episodesInfo?.append(contentsOf: resultModel.results)
                    completed(resultModel.results, nil)
                }
            }
        }
    }

    func fetchCharacters(completed: @escaping ([CharacterInfo]?, String?) -> Void) {
        (1...3).forEach { pageNumber in
            ServiceAPI.shared.fetchCharacters(method: .characters("\(pageNumber)")) { (resultModel: CharacterResultModel?, networkError: NetworkError?) in
                if networkError != nil {
                    DispatchQueue.main.async {
                        completed(nil, networkError?.errorDescription)
                    }

                    return
                }

                DispatchQueue.main.async {
                    guard let resultModel = resultModel
                    else {
                        completed(nil, networkError?.errorDescription)
                        return
                    }

                    completed(resultModel.results, nil)
                }
            }
        }
    }

    func fetchEpisodes(charactersInfo: [CharacterInfo]) {
        fetchEpisodes(completed: { [weak self] episodesInfo, error in
            guard let self = self else { return }
            guard let episodesInfo = episodesInfo else { return }

            self.episodesInfo?.append(contentsOf: episodesInfo)
            self.mergeEpisodeAndCharacters(charactersInfo: charactersInfo)
        })
    }
}
