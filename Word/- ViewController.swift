//
//  ViewController.swift
//  Word
//
//  Created by David Yépez on 4/23/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    var words = Words()
    var finalWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        wordLabel.text = "\(finalWord):"
        words.getWords(word: finalWord, apiType: "rhymes") {
            self.tableView.reloadData()
        }
        
        
        
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navigationController = segue.destination as! UINavigationController
//        let destination = navigationController.viewControllers.first as! DefinitionDetailViewController
//        destination.finalWord = "WRONG"
//    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = words.wordArray[indexPath.row].rhymes
        return cell
    }
}
