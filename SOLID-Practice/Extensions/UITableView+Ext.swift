//
//  UITableView+Ext.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        
        let bundle = Bundle(for: cell.self)
        let nib = UINib(nibName: cell.identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
}
