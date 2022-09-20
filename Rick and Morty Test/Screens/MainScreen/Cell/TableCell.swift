//
//  TableCell.swift
//  Rick and Morty Test
//
//  Created by Veaceslav Chirita on 08.09.2022.
//

import UIKit
import SDWebImage

final class TableCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var avatarImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.layer.cornerRadius = 8
        uiImageView.clipsToBounds = true
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var episodeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = UIColor(red: 1, green: 141/255, blue: 6/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //        self.backgroundColor = .clear
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        avatarImageView.image = nil
        nameLabel.text = ""
        locationLabel.text = ""
        episodeNameLabel.text = ""
    }

    private func setup() {
        self.contentView.addSubview(containerView)

        containerView.addSubview(avatarImageView)
        containerView.addSubview(mainStackView)

        episodeStackView.addArrangedSubview(episodeNameLabel)

        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(locationLabel)
        mainStackView.addArrangedSubview(episodeStackView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),

            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            avatarImageView.widthAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }

    func configureCell(characterInfo: CharacterInfo) {
        avatarImageView.sd_setImage(with: URL(string: characterInfo.image))
        nameLabel.text = characterInfo.name
        locationLabel.text = "Location: \(characterInfo.location.name)"

        episodeNameLabel.text = "Episode: \(characterInfo.episodeName)"
    }
}
