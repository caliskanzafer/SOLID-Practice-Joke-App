//
//  HomeCellItem.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 28.02.2024.
//

import UIKit

protocol HomeCellItem {
    var viewModel: HomeViewModelProtocol? { get }
    
    var orderIndex: Int { get }
    
    var numberOfRowsInSection: Int { get }
    
    var cellForRowAt: (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell { get }
    
    func titleForHeaderInSection() -> String 
    
}
