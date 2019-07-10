//
//  LoginController.swift
//  How-To
//
//  Created by Audrey Welch on 7/9/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import Foundation

class LoginController {
    
    static let shared = LoginController()
    private let baseURL = URL(string: "https://bw-howto.netlify.com/api/")!
    var userID: Int?
    var token: String?
    
    func register(with user: User, completion: @escaping (Bool) -> Void) {
        
        let parameters = ["username" : user.username, "password" : user.password, "usertype" : user.userType]
        
        let loginURL = baseURL.appendingPathComponent("register")
        let session = URLSession.shared
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            // Pass dictionary to NSData object and set it as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(JSONString!)
            
            do {
                // Create JSON object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Int] {
                    print(json)
                    
                    // Handle JSON
                    self.userID = json.first
                    completion(true)
                    
                } else {
                    completion(false)
                    
                }
            } catch let error {
                print(error.localizedDescription)
                
            }
        })
        task.resume()
    }
    
    func updateUserInfo(with user: User, completion: @escaping (Error?) -> Void) {
        
        guard let userID = userID else { return }
        let loginURL = baseURL.appendingPathComponent("users")
        let parameters = ["id" : "\(userID)", "username" : user.username, "password" : user.password, "usertype" : user.userType]
        
        // Create the session object
        let session = URLSession.shared
        
        // Create the URLRequest object using the url object
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST" // set http method as POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            // Pass dictionary to NSData object and set it as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            do {
                // Create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
        
    }
    
    func login(with user: User, completion: @escaping (String?) -> Void) {
        
        let loginURL = baseURL.appendingPathComponent("login")
        let parameters = ["username" : user.username, "password" : user.password]
        
        // Create the session object
        let session = URLSession.shared
        
        // Create the URLRequest object using the url object
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST" //set http method as POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(response!)
            print(JSONString!)
            
            do {
                // Create JSON object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    if let token = json["token"] as? String {
                        GuideController.shared.token = token
                        CategoryController.shared.token = token
                        self.token = token
                        completion(token)
                    }
                    if let id = json["userID"] as? Int {
                        GuideController.shared.userID = id
                        CategoryController.shared.userID = id
                        self.userID = id
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    
    }
}
