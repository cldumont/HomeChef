//
//  RecipeViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/16/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

protocol RecipeViewControllerDelegate: class {
    func addRecipeViewController(_ controller: RecipeViewController, didFinishAdding recipe: RecipeCard)
}

class RecipeViewController: UIViewController {
    
    weak var delegate: RecipeViewControllerDelegate?

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension RecipeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        let recipe = RecipeCard()
        if let textFieldText = textField.text {
            recipe.name = textFieldText
        }
        print(recipe.name)
        delegate?.addRecipeViewController(self, didFinishAdding: recipe)
      
        textField.resignFirstResponder()
        return true
    }
}
