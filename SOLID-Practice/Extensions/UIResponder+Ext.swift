//
//  UIResponder+Ext.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import UIKit

extension UIResponder {
    
    static var identifier: String {
        return String(describing: self.self)
    }
}
