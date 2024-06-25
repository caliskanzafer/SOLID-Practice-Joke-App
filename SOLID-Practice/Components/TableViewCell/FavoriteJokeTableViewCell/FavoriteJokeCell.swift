//
//  FavoriteJokeCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 28.02.2024.
//

import UIKit

/// This cell is designed to show favorite jokes on the homepage
final class FavoriteJokeCell: HomeCellItem {

    let viewModel: HomeViewModelProtocol?
    
    /// The order in which it will appear in the tableView on the homepage
    let orderIndex: Int = 2
    
    /// It is the joke list required for the joke to be displayed in the cell
    let jokes: [JokeModelProtocol]?
    
    /// Create a FavoriteJokeCell from the given parameters
    ///
    /// - Parameters:
    ///     - viewModel: This is required to manage data.
    ///     - jokes: It is the joke list required for the joke to be displayed in the cell
    ///
    init(viewModel: HomeViewModelProtocol, jokes: [JokeModelProtocol]?) {
        self.viewModel = viewModel
        self.jokes = jokes
    }

    /// Returns the count of `jokes`
    ///
    /// - Returns: Returns count of joke item as `Int`
    ///
    ///  ```swift
    ///
    /// let jokes = []
    /// print(numberOfRowsInSection)
    /// // 0
    ///
    /// jokes.append(JokeModel(id: "xx", value: "xx"))
    /// print(numberOfRowsInSection)
    /// // 1
    ///
    ///  ```
    var numberOfRowsInSection: Int {
        return jokes?.count ?? .zero
    }
    
    /// With this computed property, the UITableViewCell that we will use in the tableView is created.
    ///  
    /// - Returns: Returns FavoriteJokeTableViewCell
    ///
    /// ![A screenshot of an favorite cell](favoriteCell)
    ///
    /// This tableview cell was created with ``FavoriteJokeTableViewCell``
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
