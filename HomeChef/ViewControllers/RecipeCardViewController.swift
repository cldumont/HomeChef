//
//  RecipeCardViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/13/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class RecipeCardViewController: UICollectionViewController {
    
    @IBOutlet private weak var addButton: UIBarButtonItem!
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    
    var category: Category!
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                category.recipes.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "Add/Edit"
        navigationController?.isToolbarHidden = true
        
        title = category.name
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editButtonItem.title = "Add/Edit"
        addButton.isEnabled = editing
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView .cellForItem(at: indexPath) as! RecipeCell
            cell.isEditing = editing
        }
        if editing {
            navigationController?.isToolbarHidden = false
        } else {
            navigationController?.isToolbarHidden = true
        }
        
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRecipeSegue" {
            if let recipeViewController = segue.destination as? RecipeViewController {
                recipeViewController.delegate = self
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return category.recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = category.recipes[indexPath.row].name
        cell.recipeImage.image = UIImage(named: category.recipes[indexPath.row].name)
        cell.isEditing = isEditing
        return cell
    }

    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }

}

extension RecipeCardViewController: RecipeViewControllerDelegate {
    func addRecipeViewController(_ controller: RecipeViewController, didFinishAdding recipe: RecipeCard) {
        navigationController?.popViewController(animated: true)
        let card = category.recipes.count
        category.recipes.append(recipe)
        let indexPath = IndexPath(item: card, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
}
