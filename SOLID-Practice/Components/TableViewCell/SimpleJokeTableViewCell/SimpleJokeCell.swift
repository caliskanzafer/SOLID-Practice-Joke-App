//
//  SimpleJokeCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 28.02.2024.
//

import UIKit

class SimpleJokeCell: HomeCellItem, SimpleHomeCellItem {
    
    let viewModel: HomeViewModelProtocol?
    let orderIndex: Int = 1
    let joke: JokeModelProtocol?
    
    init(viewModel: HomeViewModelProtocol?, joke: JokeModelProtocol) {
        self.viewModel = viewModel
        self.joke = joke
    }
    
    var numberOfRowsInSection: Int {
        1
    }
    
    var cellForRowAt: (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return { [weak self] tableView, _ in
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleJokeTableViewCell.identifier) as! SimpleJokeTableViewCell
            cell.joke = self?.joke
            cell.delegate = self
            return cell
        }
    }
    
    func titleForHeaderInSection() -> String {
        return simpleJokeTitle()
    }
    
    func simpleJokeTitle() -> String {
        return "Joke"
    }
    
}
extension SimpleJokeCell: HomeCellDelegate {
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

extension SimpleJokeCell: SimpleHomeCellDelegate {
    func updateJoke() {
        viewModel?.getRemoteJoke()
    }
}
