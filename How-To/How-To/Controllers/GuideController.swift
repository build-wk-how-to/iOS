//
//  GuideController.swift
//  How-To
//
//  Created by Audrey Welch on 7/9/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import Foundation

class GuideController {
    
    static let shared = GuideController()
    private let baseURL = URL(string: "https://bwhowto.herokuapp.com/api/")!
    
    var guides: [Guide] = []
    var userID: Int?
    var token: String?
    
    func createRequest(url: URL, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        if let token = self.token {
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(token, forHTTPHeaderField: "Authorization")
            return request
        }
        return request
    }
    
    func fetchGuides(completion: @escaping ([Guide]) -> Void) {
        
        guard let userID = self.userID else { return }
        guard let token = self.token else { return }

        let guidesURL = baseURL.appendingPathComponent("users")
            .appendingPathComponent("guides")
        //.appendingPathComponent("\(userID)")
        
        var request = URLRequest(url: guidesURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No Data")
                return
            }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(JSONString!)
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let decodedResponse = try jsonDecoder.decode([Guide].self, from: data)
                print(decodedResponse)
                
                self.guides = decodedResponse
                completion(decodedResponse)
            } catch {
                NSLog("error decoding guides from Guide Object: \(error)")
                return
            }
        }.resume()
    }
    
    func createGuide(with guideName: String, owner: Int, guideContent: String, categoryID: Int, completion: @escaping (Error?) -> Void) {
        
        let parameters = ["guidename" : guideName, "owner" : "\(userID)", "guidecontent" : guideContent, "dateposted" : "Friday, July 12, 2019", "category" : categoryID] as [String : Any]
        
        let createGuideURL = baseURL.appendingPathComponent("users")
            .appendingPathComponent("\(userID)").appendingPathComponent("guides")
        
        let session = URLSession.shared
        var request = createRequest(url: createGuideURL, httpMethod: "POST")
        
        do {
            // Pass dictionary to NSData object and set it as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
        })
        task.resume()
        
    }
    
}
