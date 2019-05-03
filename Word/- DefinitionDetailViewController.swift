//
//  DefinitionDetailViewController.swift
//  Word
//
//  Created by David Yépez on 4/26/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit

class DefinitionDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topWordLabel: UILabel!
    
    
    var words = Words()
    var word : Word!
    var finalWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        words.getWords(word: finalWord, apiType: "definitions") {
            self.tableView.reloadData()
            print(self.words.firebaseWord.word)
            print(self.words.firebaseWord.definition)
            self.word = self.words.firebaseWord
        
}
        topWordLabel.text = "\(finalWord):"
     
   }
    
    
    @IBAction func addToFavoritesButtonPressed(_ sender: UIBarButtonItem) {

        
        word.saveData { success in
            if success {
                
                self.performSegue(withIdentifier: "definitionToFavoritesSegue", sender: self)
            } else {
                print("ERROR: data unsaved")
            }
        }
    }
    
    
    
}


extension DefinitionDetailViewController: UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.definitionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionTableViewCell
        //cell.textLabel?.text = words.definitionArray[indexPath.row].partOfSpeech
        var printout = "(\(words.definitionArray[indexPath.row].partOfSpeech)): \(words.definitionArray[indexPath.row].definition)"
        cell.definitionLabel.text = printout
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}
