//
//  FavoriteJokeTableViewCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

class FavoriteJokeTableViewCell: UITableViewCell, HomeCellProtocol {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: HomeCellDelegate?
    
    var joke: JokeModelProtocol? {
        didSet {
            titleLabel.text = joke?.value
            if let jokeId = joke?.id {
                
                if let _ = delegate?.getJoke(id: jokeId) {
                    isExist = true
                }else {
                    isExist = false
                }
            }
        }
    }
    
    var isExist: Bool = false {
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
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        if let joke {
            if isExist {
                delegate?.deleteJoke(item: joke)
            }else {
                delegate?.saveJoke(item: joke)
            }
            delegate?.updateTableView()
        }
    }
}
