//
//  EmployeeCollectionViewCell.swift
//  AvitoTestTask
//
//  Created by Apple on 03.09.2021.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .systemFont(ofSize: 15)
        return nameLabel
    }()

    let phoneNumberLabel: UILabel = {
        var phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.numberOfLines = 1
        phoneNumberLabel.font = .systemFont(ofSize: 15)
        return phoneNumberLabel
    }()

    let skillsLabel: UILabel = {
        var skillsLabel = UILabel()
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.numberOfLines = 2
        skillsLabel.font = .systemFont(ofSize: 15)
        return skillsLabel
    }()

    let separatorViewUnderNameLabel: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()

    let separatorViewUnderPhoneLabel: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(skillsLabel)
        contentView.addSubview(separatorViewUnderNameLabel)
        contentView.addSubview(separatorViewUnderPhoneLabel)

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8

        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            separatorViewUnderNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            separatorViewUnderNameLabel.heightAnchor.constraint(equalToConstant: 0.5),
            separatorViewUnderNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            separatorViewUnderNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            phoneNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            phoneNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            separatorViewUnderPhoneLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            separatorViewUnderPhoneLabel.heightAnchor.constraint(equalToConstant: 0.5),
            separatorViewUnderPhoneLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            separatorViewUnderPhoneLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            skillsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            skillsLabel.heightAnchor.constraint(equalToConstant: 30),
            skillsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
