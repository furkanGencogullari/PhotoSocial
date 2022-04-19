//
//  SettingsViewController.swift
//  PhotoSocial
//
//  Created by Furkan Gençoğulları on 18.04.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.text = Auth.auth().currentUser?.email!

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        } catch {
        }
    }
}
