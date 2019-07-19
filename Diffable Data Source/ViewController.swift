//
//  ViewController.swift
//  Diffable Data Source
//
//  Created by Viswa Kodela on 7/18/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Init
    
    
    
    // MARK:- Properties
    
    private var users = [User]()
    private let cellID = "cellID"
    private var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    private let searchBar = UISearchBar(frame: .zero)
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    private enum Section: Hashable {
        case Main
    }
    
    
    // MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureNavigationBar()
        configureSearchBar()
        configureDataSource()
        
    }
    
    // MARK:- Helper Methods
    private func configureLayout() {
        view.backgroundColor = UIColor.white
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: cellID)
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationController?.navigationBar.tintColor = UIColor.systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Users"
    }
    
    private func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.placeholder = "Search.."
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView, cellProvider: { (cv, indexPath, user) -> UICollectionViewCell? in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! LabelCell
            cell.nameLabel.text = user.name
            return cell
        })
    }
    
    private func createSnapshot(from users: [User]) {
        let snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        
        snapshot.appendSections([.Main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK:- Action Methods
extension ViewController {
    @objc private func handleAdd() {
        let alertController = UIAlertController(title: "Add New User", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter user's name"
        }
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            let username = alertController.textFields?.first?.text ?? ""
            if !username.isEmpty {
                let user = User(name: username)
                self?.users.append(user)
                self?.createSnapshot(from: self?.users ?? [])
            }
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK:- Search Bar Delegate Methods
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
