//
//  RecipeCell.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/12/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeName: UILabel!
    
    override func awakeFromNib() {
        
        recipeImage.layer.borderWidth = 1
        recipeImage.layer.cornerRadius = 8
        
    }
}
