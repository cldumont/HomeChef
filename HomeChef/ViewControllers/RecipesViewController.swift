//
//  RecipesViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/13/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class RecipesViewController: UICollectionViewController {
    
    var recipes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = recipes[indexPath.row]
        return cell
    }

    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
