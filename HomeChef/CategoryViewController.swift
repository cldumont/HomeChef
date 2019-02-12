//
//  ViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/11/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Chef"
    }

}

// MARK:- CollectionView Delegates
extension CategoryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = "Red"
        return cell
    }
    
}

