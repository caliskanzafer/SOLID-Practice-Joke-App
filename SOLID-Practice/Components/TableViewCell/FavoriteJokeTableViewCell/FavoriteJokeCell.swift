//
//  FavoriteJokeCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 28.02.2024.
//

import UIKit

class FavoriteJokeCell: HomeCellItem {

    let viewModel: HomeViewModelProtocol?
    let orderIndex: Int = 2
    let jokes: [JokeModelProtocol]?
    
    init(viewModel: HomeViewModelProtocol, jokes: [JokeModelProtocol]?) {
        self.viewModel = viewModel
        self.jokes = jokes
    }

    var numberOfRowsInSection: Int {
        return jokes?.count ?? .zero
    }
    
    var cellForRowAt: (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return { [weak self] tableView, indexPath in
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteJokeTableViewCell.identifier) as! FavoriteJokeTableViewCell
            cell.joke = self?.jokes?[safe: indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func titleForHeaderInSection() -> String {
        "Favorites"
    }
    
}
extension FavoriteJokeCell: HomeCellDelegate {
    func getJoke(id: String) -> JokeModelProtocol? {
        return viewModel?.getJoke(id: id)
    }
    
    func saveJoke(item: JokeModelProtocol) {
        viewModel?.saveJoke(item: item)
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        viewModel?.deleteJoke(item: item)
    }
    
    func updateTableView() {
        viewModel?.getFavoriteJoke()
    }
}
