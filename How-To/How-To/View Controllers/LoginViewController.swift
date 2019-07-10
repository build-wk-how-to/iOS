//
//  LoginViewController.swift
//  How-To
//
//  Created by Audrey Welch on 7/10/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameOutlet.delegate = self
        passwordOutlet.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if let username = usernameOutlet.text, !username.isEmpty,
            let password = passwordOutlet.text, !password.isEmpty {
            
            let user = User(username: username, password: password, userType: "Content")
            LoginController.shared.login(with: user) { (token) in
                
                if token != nil {
                    // Fetch Guides
                    // GuideController.shared.fetchGuides(completion: { (guides) in
                    //    print(guides)
                    // })
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.displayAlertMessage(userMessage: "Username and Password do not match")
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: sender)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameOutlet.resignFirstResponder()
        passwordOutlet.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
}
