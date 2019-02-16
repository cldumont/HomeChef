//
//  RecipeCardViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/13/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class RecipeCardViewController: UICollectionViewController {
    
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

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = data.recipes[indexPath.row].name
        cell.recipeImage.image = UIImage(named: data.recipes[indexPath.row].name)
        return cell
    }

    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRecipeSegue" {
            if let recipeViewController = segue.destination as? RecipeViewController {
                recipeViewController.delegate = self
            }
        }
    }
}

extension RecipeCardViewController: RecipeViewControllerDelegate {
    func addRecipeViewController(_ controller: RecipeViewController, didFinishAdding recipe: RecipeCard) {
        navigationController?.popViewController(animated: true)
        let card = data.recipes.count
        data.recipes.append(recipe)
        let indexPath = IndexPath(row: card, section: 0)
        let indexPaths = [indexPath]
        collectionView.insertItems(at: indexPaths)
    }
    
}
