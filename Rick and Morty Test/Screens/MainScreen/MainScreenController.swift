//
//  ViewController.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit

class MainScreenController: UIViewController {
    var viewModel: MainScreenProtocol?
    var charactersInfo: [CharacterInfo] = []
    var episodesInfo: [EpisodeResult] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: MainScreenProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel as? MainScreenViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchCharacters()
    }

    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Rick And Morty"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func fetchCharacters() {
        viewModel?.fetchCharacters(completed: { [weak self] charactersInfo, error in
            guard let self = self else { return }
            guard let charactersInfo = charactersInfo else { return }
            self.charactersInfo.append(contentsOf: charactersInfo)
            self.viewModel?.fetchEpisodes(charactersInfo: charactersInfo)
            self.tableView.reloadData()
        })
    }
}

extension MainScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }

        let character = charactersInfo[indexPath.row]
        cell.configureCell(characterInfo: character)
        return cell
    }
}

extension MainScreenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCharacter = charactersInfo[indexPath.row]

        viewModel?.moveToDetailScreen(selectedCharacter: selectedCharacter,
                                      episodeName: selectedCharacter.episodeName,
                                      characterArray: charactersInfo
        )
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
