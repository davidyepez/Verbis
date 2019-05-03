//
//  FavoritesViewController.swift
//  Word
//
//  Created by David Yépez on 4/28/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    

    var words: Words!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        words = Words()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        
        words.loadData {
            self.favoritesTableView.reloadData()
        }
    }
    

}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = words.favoritesArray[indexPath.row].word
        //cell.textLabel?.text = words.favoritesArray[indexPath.row].definition
        return cell
    }
    
}
