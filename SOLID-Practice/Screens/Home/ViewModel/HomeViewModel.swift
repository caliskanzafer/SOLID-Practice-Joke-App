//
//  HomeViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    
    let dataProvider: HomeDataProviderProtocol
    
    init(dataProvider: HomeDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    weak var delegate: HomeViewControllerDelegate?
    
    var cellList: [HomeCellItem] = [] {
        didSet {
            sortCells()
        }
    }
    
    func getRemoteJoke() {
        dataProvider.getRemoteJoke { [weak self] joke in
            guard let self = self, let joke else { return }
            
            self.updateRemoteJoke(with: joke)
            
            self.delegate?.reloadTableView()
        }
    }
    
    
    func getFavoriteJoke() {
        let jokeList = dataProvider.getFavoriteJokes()
        
        updateFavoriteJokes(with: jokeList)
        
        delegate?.reloadTableView()
    }

    func getJoke(id: String) -> JokeModelProtocol? {
        return dataProvider.getJoke(id: id)
    }
    
    func saveJoke(item: JokeModelProtocol) {
        dataProvider.saveJoke(item: item)
        
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        dataProvider.deleteJoke(item: item)
    }

}

private extension HomeViewModel {
    
    func sortCells() {
        cellList.sort(by: { s1, s2 in
            s1.orderIndex < s2.orderIndex
        })
    }
    
    func updateRemoteJoke(with joke: JokeModelProtocol) {
        self.cellList.removeAll { cell in
            type(of: cell) == SimpleJokeCell.self
        }
        
        self.cellList.append(SimpleJokeCell(viewModel: self, joke: joke))
    }
    
    func updateFavoriteJokes(with jokes: [JokeModelProtocol]) {
        self.cellList.removeAll { cell in
            type(of: cell) == FavoriteJokeCell.self
        }
        
        self.cellList.append(FavoriteJokeCell(viewModel: self, jokes: jokes))
    }
}
