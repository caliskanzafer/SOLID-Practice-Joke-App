//
//  SimpleJokeTableViewCell.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

protocol HomeCellDelegate: AnyObject {
    func updateTableView()
    func updateJoke()
    func getJoke(id: String) -> JokeModelProtocol?
    func saveJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
}

class SimpleJokeTableViewCell: UITableViewCell, HomeCellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        if let joke {
            if isExist {
                delegate?.deleteJoke(item: joke)
            }else {
                delegate?.saveJoke(item: joke)
                delegate?.updateJoke()
            }
            
            delegate?.updateTableView()
        }
    }
    
    @IBAction func newJokePressed(_ sender: Any) {
        delegate?.updateJoke()
    }
    
}
