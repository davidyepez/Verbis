//
//  RhymeTextFieldViewController.swift
//  Word
//
//  Created by David Yépez on 4/23/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RhymeTextFieldViewController: UIViewController {
    
    @IBOutlet weak var showRhymesButton: UIButton!
    @IBOutlet weak var wordTextField: UITextField!
    var chosenWord = ""
    
    //*****
    var wordArray : [WordInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func wordTextFieldChanged(_ sender: UITextField) {
        chosenWord = sender.text!
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        wordTextField.resignFirstResponder()
    }
  
    
    
    
    @IBAction func showRhymesButtonPressed(_ sender: UIButton) {
        wordTextField.resignFirstResponder()
        wordTextField.text = ""
        performSegue(withIdentifier: "showRhymesSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var vc = segue.destination as! ViewController
//        vc.finalWord = self.chosenWord
//    }
    
    
//For passing information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        //let destination = navigationController.viewControllers.first as! ViewController
        destination.finalWord = self.chosenWord
    }


    
    
    
}


