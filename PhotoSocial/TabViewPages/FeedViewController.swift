//
//  FeedViewController.swift
//  PhotoSocial
//
//  Created by Furkan Gençoğulları on 18.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userImageArray = [String]()
    var userDescriptionArray = [String]()
    var userLikesArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(patternImage: UIImage(named: "tabBarBackground")!)
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarController?.tabBar.standardAppearance
        
        getDataFromFirestore()
        

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.userDescription.text = userDescriptionArray[indexPath.row]
        cell.likeCountLabel.text = String(userLikesArray[indexPath.row])
        //cell.imageView?.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.imageView?.image = UIImage(named: "image-2")
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func getDataFromFirestore() {
        let db = Firestore.firestore()
        db.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                
            } else {
                if snapshot?.isEmpty != true {
                    for doc in snapshot!.documents {
                        let documentID = doc.documentID
                        print(documentID)
                        
                        if let postedBy = doc.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let description = doc.get("description") as? String {
                            self.userDescriptionArray.append(description)
                        }
                        if let likes = doc.get("likes") as? Int {
                            self.userLikesArray.append(likes)
                        }
                        if let image = doc.get("imageUrl") as? String {
                            self.userImageArray.append(image)
                        }
                    }
                }
                self.tableView.reloadData()
                
            }
        }
    }

  
}
