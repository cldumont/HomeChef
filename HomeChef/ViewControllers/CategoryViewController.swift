//
//  ViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/11/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {
    
    var data: DataSource
    
    required init?(coder aDecoder: NSCoder) {
        
        data = DataSource()
        super.init(coder: aDecoder)
        
    }
   
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
        return data.categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCell
        
        cell.recipeName.text = data.categories[indexPath.row].name
        cell.recipeImage.image = UIImage(named: data.categories[indexPath.row].image)
        
        return cell
    }
 
 // MARK:- UICollectionViewDelegate
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "RecipesView", sender: indexPath)
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "RecipesView" {
//            if let dest = segue.destination as? RecipesViewController, let index = sender as? IndexPath {
//                dest.selection =
//
//            }
//        }
//    }

}

