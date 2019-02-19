//
//  ViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/11/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {
    
    //let cellIdentifier = "CategoryCell"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: cellIdentifier)
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
}

extension CategoryViewController {
    
// MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! RecipeCell

        cell.recipeName.text = "Cat"
        //cell.recipeImage.image = UIImage(named: categories[indexPath.row].name)
    
        return cell
    }
 
 // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "ShowRecipeCard", sender: nil)

    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "RecipesView" {
//            if let dest = segue.destination as? RecipeCardViewController, let index = sender as? IndexPath {
//                dest.selection =
//
//            }
//        }
//    }

}

