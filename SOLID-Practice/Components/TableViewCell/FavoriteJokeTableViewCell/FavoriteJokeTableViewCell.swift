//
//  FavoriteJokeTableViewCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

class FavoriteJokeTableViewCell: UITableViewCell {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var coreDataService = CoreDataService()
    
    var updateTableView: (() -> Void)?
    
    var joke: JokeModel? {
        didSet {
            titleLabel.text = joke?.value
            if let jokeId = joke?.id {
                
                if let _ = coreDataService.getJoke(id: jokeId) {
                    isExist = true
                }else {
                    isExist = false
                }
            }
        }
    }
    
    private var isExist: Bool = false {
        didSet {
            if isExist {
                favButton.setTitle("Fav Çıkar", for: .normal)
            }else {
                favButton.setTitle("Fav Ekle", for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        if let joke {
            if isExist {
                coreDataService.deleteItem(item: joke)
            }else {
                coreDataService.saveFavoriteJoke(item: joke)
            }
            updateTableView?()
        }
    }
}
