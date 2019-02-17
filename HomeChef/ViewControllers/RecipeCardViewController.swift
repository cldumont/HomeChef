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
    
    var data: DataSource
    
    required init?(coder aDecoder: NSCoder) {
        
        data = DataSource()
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                data.recipes.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
        navigationController?.isToolbarHidden = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
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
            let cell = collectionView .cellForItem(at: indexPath) as! RecipeCell
            cell.isEditing = editing
        }
        //deleteButton.isEnabled = isEditing
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRecipeSegue" {
            if let recipeViewController = segue.destination as? RecipeViewController {
                recipeViewController.delegate = self
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = data.recipes[indexPath.row].name
        cell.recipeImage.image = UIImage(named: data.recipes[indexPath.row].name)
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
        let card = data.recipes.count
        data.recipes.append(recipe)
        let indexPath = IndexPath(row: card, section: 0)
        let indexPaths = [indexPath]
        collectionView.insertItems(at: indexPaths)
    }
    
}
