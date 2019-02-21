//
//  DataSource.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/13/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import Foundation

class DataSource {
    var categories = [Category]()
    
    init() {
        loadCategories()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("HomeChef.plist")
    }
    
    func saveCategories() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(categories)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding category array: \(error.localizedDescription)")
        }
    }
    
    func loadCategories() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                categories = try decoder.decode([Category].self, from: data)
            } catch {
                print("Error decoding category array: \(error.localizedDescription)")
            }
        }
    }
}
