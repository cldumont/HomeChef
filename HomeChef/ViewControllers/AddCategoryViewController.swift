//
//  AddCategoryViewController.swift
//  HomeChef
//
//  Created by Craig Dumont on 2/19/19.
//  Copyright © 2019 Craig Dumont. All rights reserved.
//

import UIKit

protocol CategoryViewControllerDelegate: class {
    func addCategoryViewController(_ controller: AddCategoryViewController, didFinishAdding recipe: Category)
}

class AddCategoryViewController: UIViewController {
    
    weak var delegate: CategoryViewControllerDelegate?
    
    @IBOutlet weak var addCategoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AddCategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        let category = Category()
        if let textFieldText = textField.text {
            category.name = textFieldText
        }
        delegate?.addCategoryViewController(self, didFinishAdding: category)
        
        textField.resignFirstResponder()
        return true
    }
    
}
