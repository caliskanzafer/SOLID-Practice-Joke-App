//
//  HomeViewController.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 24.02.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        viewModel.delegate = self
        reloadAllData()
//        viewModel.deleteAllJokes()
    }
    
}

private extension HomeViewController {
    func configureTableView() {
        tableView.register(cell: FavoriteJokeTableViewCell.self)
        tableView.register(cell: SimpleJokeTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func reloadAllData() {
        
        viewModel.getRemoteJoke()
        viewModel.getFavoriteJoke()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.cellList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellItem = viewModel.cellList[section]
        return cellItem.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = viewModel.cellList[indexPath.section]
        return cellItem.cellForRowAt(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cellItem = viewModel.cellList[section]
        return cellItem.titleForHeaderInSection()
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

