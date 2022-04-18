//
//  ViewController.swift
//  PhotoSocial
//
//  Created by Furkan Gençoğulları on 16.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    let logo = UIImageView()
    let background = UIImageView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signupButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let height = view.bounds.height
        let width = view.bounds.width
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = CGRect(x: width * 0.5 - width * 0.4, y: height * 0.5 - height * 0.25, width: width * 0.8, height: height * 0.5)
        visualEffectView.layer.cornerRadius = 30
        visualEffectView.layer.masksToBounds = true
        
        
        logo.frame = CGRect(x: width * 0.5 - (width * 0.6 / 2), y: height * 0.3, width: width * 0.6, height: height * 0.1)
        logo.image = UIImage(named: "Photo Social")
        logo.contentMode = .scaleAspectFit
        
        
        emailTextField.frame = CGRect(x: width * 0.5 - (width * 0.7 / 2), y: height * 0.4, width: width * 0.7, height: height * 0.05)
        emailTextField.placeholder = "  Email"
        emailTextField.backgroundColor = .white
        emailTextField.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        emailTextField.layer.shadowOpacity = 0.3
        emailTextField.layer.cornerRadius = 10
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        
        
        passwordTextField.frame = CGRect(x: width * 0.5 - (width * 0.7 / 2), y: height * 0.47, width: width * 0.7, height: height * 0.05)
        passwordTextField.placeholder = "  Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        passwordTextField.layer.shadowOpacity = 0.3
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        
        
        loginButton.frame = CGRect(x: width * 0.5 - width * 0.1 , y: height * 0.57, width: width * 0.2, height: height * 0.04)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.tintColor = UIColor(red: 255/255, green: 88/255, blue: 255/255, alpha: 1)
        loginButton.configuration = .filled()
        loginButton.titleLabel?.textColor = .white
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(loginPressed), for: UIControl.Event.touchUpInside)
        
        
        signupButton.frame = CGRect(x: width * 0.5 - width * 0.1 , y: height * 0.63, width: width * 0.2, height: height * 0.04)
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.tintColor = UIColor(red: 255/255, green: 88/255, blue: 255/255, alpha: 1)
        signupButton.configuration = .plain()
        signupButton.titleLabel?.textColor = .white
        signupButton.titleLabel?.adjustsFontSizeToFitWidth = true
        signupButton.titleLabel?.textAlignment = .center
        signupButton.addTarget(self, action: #selector(signupPressed), for: UIControl.Event.touchUpInside)
        
        
        view.addSubview(visualEffectView)
        view.addSubview(logo)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
    }
    
    @objc func loginPressed () {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Please enter username and password")
        }
        
    }
    @objc func signupPressed () {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Please enter username and password")
        }
    }
    func makeAlert (titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    


}

