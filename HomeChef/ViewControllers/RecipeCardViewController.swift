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
    
    var recipes = [RecipeCard]()
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                recipes.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
        navigationController?.isToolbarHidden = true
        
        saveRecipes()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
        
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        loadRecipes()
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("HomeChef.plist")
    }
    
    func saveRecipes() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(recipes)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding recipes array: \(error.localizedDescription)")
        }
    }
    
    func loadRecipes() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                recipes = try decoder.decode([RecipeCard].self, from: data)
            } catch {
                print("Error decoding recipes array: \(error.localizedDescription)")
            }
        }
        
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
        
        saveRecipes()
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
        
        return recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = recipes[indexPath.row].name
        cell.recipeImage.image = UIImage(named: recipes[indexPath.row].name)
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
        let card = recipes.count
        recipes.append(recipe)
        let indexPath = IndexPath(row: card, section: 0)
        let indexPaths = [indexPath]
        collectionView.insertItems(at: indexPaths)
        
        saveRecipes()
    }
    
}
