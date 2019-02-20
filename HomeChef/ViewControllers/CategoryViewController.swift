//
//  ViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/11/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {
    
    @IBOutlet private weak var addButton: UIBarButtonItem!
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    
    var categories = [Category]()
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                categories.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
        navigationController?.isToolbarHidden = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        title = "Categories"
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        var category = Category()
        category.name = "salad"
        categories.append(category)
        
        category = Category()
        category.name = "soup"
        categories.append(category)
        
        category = Category()
        category.name = "meat"
        categories.append(category)
        
        category = Category()
        category.name = "fish"
        categories.append(category)
        
        category = Category()
        category.name = "pasta"
        categories.append(category)
        
        category = Category()
        category.name = "vegetable"
        categories.append(category)
        
        category = Category()
        category.name = "dessert"
        categories.append(category)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! RecipeCell
            cell.isEditing = editing
        }
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeCard" {
            let controller = segue.destination as! RecipeCardViewController
            controller.category = sender as? Category
        } else if segue.identifier == "AddCategorySegue" {
            if let addCategoryViewController = segue.destination as? AddCategoryViewController {
                addCategoryViewController.delegate = self
            }
        }
    }
    
}

extension CategoryViewController {
    
// MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! RecipeCell
        
        let category = categories[indexPath.row]
        cell.recipeName.text = category.name
        cell.recipeImage.image = UIImage(named: category.name)
        cell.isEditing = isEditing
    
        return cell
    }
 
 // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let category = categories[indexPath.row]
            performSegue(withIdentifier: "ShowRecipeCard", sender: category)
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

extension CategoryViewController: CategoryViewControllerDelegate {
    func addCategoryViewController(_ controller: AddCategoryViewController, didFinishAdding category: Category) {
        navigationController?.popViewController(animated: true)
        let card = categories.count
        categories.append(category)
        let indexPath = IndexPath(item: card, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
}

