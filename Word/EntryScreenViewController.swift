//
//  EntryScreenViewController.swift
//  Word
//
//  Created by David Yépez on 4/26/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class EntryScreenViewController: UIViewController {

    var authUI: FUIAuth!
    var word: Word!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = self


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
            ]
        if authUI.auth?.currentUser == nil {
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        do {
            try authUI.signOut()
            signIn()
        } catch {
            print("ERROR: couldn't sign out")
        }
    }
    

    @IBAction func rhymeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "rhymeTextFieldSegue", sender: self)
    }
    
    @IBAction func defineButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "defineTextFieldSegue", sender: self)
    }
    

}

extension EntryScreenViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            print("***We signed in with the user \(user.email ?? "Unknown email")")
        }
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        loginViewController.view.backgroundColor = UIColor.white
        
        let marginInsets : CGFloat = 16
        let imageHeight : CGFloat = 350
        let imageY = self.view.center.y - imageHeight
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets*2), height: imageHeight)
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "verbis2")
        logoImageView.contentMode = .scaleAspectFit
        loginViewController.view.addSubview(logoImageView)
        
        return loginViewController
    }
    
    
}
