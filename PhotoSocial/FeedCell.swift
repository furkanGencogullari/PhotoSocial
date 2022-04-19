//
//  FeedCell.swift
//  PhotoSocial
//
//  Created by Furkan Gençoğulları on 18.04.2022.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        print("like pressed")
        let db = Firestore.firestore()
        
        if let likeCount = Int(likeCountLabel.text!){
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            db.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
    }
    
}
