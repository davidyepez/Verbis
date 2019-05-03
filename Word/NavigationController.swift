//
//  DefinitionTextFieldNavigationController.swift
//  Word
//
//  Created by David Yépez on 4/27/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        //self.navigationBar.backgroundColor = UIColor.black
    }
    

  

}
