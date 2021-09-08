//
//  ViewController.swift
//  AvitoTestTask
//
//  Created by Apple on 03.09.2021.
//

import UIKit

class ViewController: UIViewController {

    var networkManager: NetworkOutput
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    init(networkManager: NetworkOutput) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        networkManager.getJson()
        configCollectionView()
        constraintLayout()
        callFromNetworkManager()
    }

    func configCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.register(EmployeeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EmployeeCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func constraintLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func callFromNetworkManager() {
        networkManager.reload = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        networkManager.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                let alertController = UIAlertController(title: "Отсутствует интернет соединение", message: "Продолжить без подключения", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                    //  add ok-button pressed action
                    //  fatalError()
                }
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 32
        return CGSize(width: width, height: 150)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.welcome?.company.employees.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewCell.self), for: indexPath) as! EmployeeCollectionViewCell
        let dataSource = networkManager.welcome!.company.employees[indexPath.row]
        cell.nameLabel.text = "Name: \(dataSource.name)"
        cell.phoneNumberLabel.text = "Phone number: \(dataSource.phoneNumber)"
        cell.skillsLabel.text = "Skills: \(dataSource.skills.joined(separator: ", "))"
        title = networkManager.welcome!.company.name
        return cell
    }
}

