//
//  UploadViewController.swift
//  PhotoSocial
//
//  Created by Furkan Gençoğulları on 18.04.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadButton.isHidden = true

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func imagePressed () {
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        imageView.contentMode = .scaleAspectFit
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        uploadButton.isHidden = false
        dismiss(animated: true)
    }
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestorePost = [
                                "imageUrl": imageUrl!,
                                "postedBy": Auth.auth().currentUser!.email!,
                                "description": self.descriptionTextView.text!,
                                "date": FieldValue.serverTimestamp(),
                                "likes": 0] as [String : Any]
                            
                            let db = Firestore.firestore()
                            var ref: DocumentReference? = nil
                            ref = db.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "select-image")
                                    self.descriptionTextView.text = "Enter your description"
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}
