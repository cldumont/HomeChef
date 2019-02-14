//
//  ViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/11/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {
    var food = "red"
    var collectionData = ["Salad", "Hamburger", "French Fries" , "Spaghetti", "Meatloaf", "Steak", "Chicken", "Taco", "Cake", "Pudding"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }

}

extension CategoryViewController {
    
// MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCell
        cell.recipeName.text = collectionData[indexPath.row]
        
        return cell
    }
 
// MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        performSegue(withIdentifier: "RecipesView", sender: nil)
    
    }
    
}

