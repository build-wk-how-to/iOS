//
//  SignUpViewController.swift
//  How-To
//
//  Created by Audrey Welch on 7/10/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

enum LoginType {
    case signup
    case login
}

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty {
            
            if password != repeatPassword {
                displayAlertMessage(userMessage: "Passwords do not match. Please try again.")
            }
            
            // Holds the userType selected from the segmented control
            var userType: String
            
            // Get selected user type
            switch userTypeSegmentedControl.selectedSegmentIndex {
            case 0:
                userType = UserType.view.rawValue
            default: // case 1:
                userType = UserType.create.rawValue
            }
            
            let user = User(username: username, password: password, userType: userType)
            
            LoginController.shared.register(with: user) { (bool) in
                if bool {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign Up Successful!", message: "Please log in with your new username and password.", preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true, completion: {
                            
                        })
                    }
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign Up Unsuccessful", message: "Please try again.", preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true, completion: {
                            
                        })
                    }
                }
            }
        } else {
            displayAlertMessage(userMessage: "All fields are required")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
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
