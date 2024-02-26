//
//  SettingsViewController.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func newJokePressed(_ sender: Any) {
        viewModel.getRemoteJoke()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.jokes[indexPath.section]
        
        switch cellType {
        case .remote(let joke):
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleJokeTableViewCell.identifier) as! SimpleJokeTableViewCell
            cell.joke = joke
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.jokes[safe: indexPath.section] {
        case .remote(let joke):
            if let joke {
                viewModel.saveFavoriteJoke(item: joke)
            }
        default:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Şaka"
        }else {
            return nil
        }
    }
}

extension SettingsViewController: HomeCellDelegate {
    func updateTableView() {
        
    }
    
    func updateJoke() {
        viewModel.getRemoteJoke()
    }
}
