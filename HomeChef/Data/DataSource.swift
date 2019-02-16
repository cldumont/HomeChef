//
//  DataSource.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/13/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import Foundation

class DataSource {
    
    var categories: [RecipeCard] = []
    
    init() {
        
        let item0 = RecipeCard()
        let item1 = RecipeCard()
        let item2 = RecipeCard()
        let item3 = RecipeCard()
        let item4 = RecipeCard()
        let item5 = RecipeCard()
        let item6 = RecipeCard()
        
        item0.name = "Salad"
        item1.name = "Soup"
        item2.name = "Meat"
        item3.name = "Fish"
        item4.name = "Vegetable"
        item5.name = "Pasta"
        item6.name = "Dessert"
        
        item0.image = "Salad"
        item1.image = "Soup"
        item2.image = "Meat"
        item3.image = "Fish"
        item4.image = "Vegetable"
        item5.image = "Pasta"
        item6.image = "Dessert"
        
        categories.append(item0)
        categories.append(item1)
        categories.append(item2)
        categories.append(item3)
        categories.append(item4)
        categories.append(item5)
        categories.append(item6)
    }

}
