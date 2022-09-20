//
//  DetailScreenViewController.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 18.09.2022.
//

import UIKit
import SDWebImage

class DetailScreenViewController: UIViewController {
    var viewModel: DetailScreenViewModel?
    var selectedCharacter: CharacterInfo
    var filteredCharacters: [CharacterInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var knownLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Last known location:"
        label.textColor = .orange
        label.font = .systemFont(ofSize: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var firstSeenLabel: UILabel = {
        let label = UILabel()
        label.text = "First seen in:"
        label.textColor = .orange
        label.font = .systemFont(ofSize: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var episodeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusColorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var statusHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Status:"
        label.textColor = .orange
        label.font = .systemFont(ofSize: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var alsoInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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

    init(viewModel: DetailScreenProtocol, selectedCharacter: CharacterInfo) {
        self.viewModel = viewModel as? DetailScreenViewModel
        self.selectedCharacter = selectedCharacter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fillTable()
    }

    private func setupUI() {
        view.backgroundColor = .white

        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(avatarImageView)
        view.addSubview(containerStackView)
        view.addSubview(alsoInLabel)
        view.addSubview(tableView)

        containerStackView.addArrangedSubview(locationStackView)
        containerStackView.addArrangedSubview(episodeStackView)
        containerStackView.addArrangedSubview(statusStackView)

        locationStackView.addArrangedSubview(knownLocationLabel)
        locationStackView.addArrangedSubview(locationLabel)

        episodeStackView.addArrangedSubview(firstSeenLabel)
        episodeStackView.addArrangedSubview(episodeLabel)

        statusStackView.addArrangedSubview(statusHeaderLabel)
        statusStackView.addArrangedSubview(statusColorStackView)

        statusColorStackView.addArrangedSubview(colorView)
        statusColorStackView.addArrangedSubview(statusLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 170),
            avatarImageView.heightAnchor.constraint(equalToConstant: 170),

            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            colorView.widthAnchor.constraint(equalToConstant: 10),
            colorView.heightAnchor.constraint(equalToConstant: 10),

            alsoInLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30),
            alsoInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            alsoInLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: alsoInLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])


    }

    private func fillData() {
        self.title = selectedCharacter.name
        avatarImageView.sd_setImage(with: URL(string: selectedCharacter.image))

        locationLabel.text = selectedCharacter.location.name
        episodeLabel.text = selectedCharacter.episodeName
        statusLabel.text = selectedCharacter.status

        switch selectedCharacter.status {
        case "Alive":
            colorView.backgroundColor = .green
        case "Dead":
            colorView.backgroundColor = .red
        default:
            colorView.backgroundColor = .black
        }


        alsoInLabel.text = "Also from \"\(selectedCharacter.episodeName)\""
    }

    private func fillTable() {
        fillData()
        filteredCharacters = viewModel?.filterCharacters(selectedCharacter: selectedCharacter) ?? []
    }
}

extension DetailScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = filteredCharacters[indexPath.row]
        fillTable()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension DetailScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }

        let character = filteredCharacters[indexPath.row]

        cell.configureCell(characterInfo: character)
        return cell
    }
}
