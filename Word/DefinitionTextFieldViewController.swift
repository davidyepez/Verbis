//
//  DefinitionTextFieldViewController.swift
//  Word
//
//  Created by David Yépez on 4/26/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit

class DefinitionTextFieldViewController: UIViewController {
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var showDefinitionsButton: UIButton!
    var chosenWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func wordTextFieldChanged(_ sender: UITextField) {
        chosenWord = sender.text!
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        wordTextField.resignFirstResponder()
    }
    
    @IBAction func showDefinitionsButtonPressed(_ sender: UIButton) {
        wordTextField.resignFirstResponder()
        wordTextField.text = ""
        performSegue(withIdentifier: "showDefinitionFromDefineSegue", sender: self)
        
//        if wordTextField.text == "Orange" {
//            wordTextField.text = ""
//            performSegue(withIdentifier: "niceTrySegue", sender: self)
//        } else {
//            wordTextField.text = ""
//            performSegue(withIdentifier: "showDefinitionFromDefineSegue", sender: self)
//        }
        
    }
    
//For passing information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DefinitionDetailViewController
        //let destination = navigationController.viewControllers.first as! DefinitionDetailViewController
        destination.finalWord = self.chosenWord
    }
}
