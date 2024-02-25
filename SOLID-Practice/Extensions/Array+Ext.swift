//
//  Array+Ext.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

extension Array {
    subscript(safe index: Int?) -> Element? {
        
        guard let index = index,
                index >= .zero,
                index < self.count else {
            return nil
        }
        return self[index]
    }
}
