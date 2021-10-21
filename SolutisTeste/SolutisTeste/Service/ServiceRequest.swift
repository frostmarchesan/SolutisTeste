//
//  ServiceRequest.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 19/10/21.
//

import Foundation
import UIKit

struct ServiceRequest {
    
    // Perform API request for login the user
    func performLoginRequest(urlString: String, userLogin: String, userPassword: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "username": userLogin,
                "password": userPassword
            ]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            } catch let error {
                print(error.localizedDescription)
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          // check for fundamental networking error
                          print("error", error ?? "Unknown error")
                          return
                      }
                
                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }
                do {
                    let jsonResponse = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(jsonResponse))
                    print("responseString = \(jsonResponse)")
                }
                catch {
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    // Perform API request for Statement data
    func performStatementRequest(urlString: String, userToken: String, completion: @escaping (Result<[Statement], Error>) -> Void) {
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue(userToken, forHTTPHeaderField: "token")

//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//            } catch let error {
//                print(error.localizedDescription)
//            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          // check for fundamental networking error
                          print("error", error ?? "Unknown error")
                          return
                      }
                
                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }
                do {
                    let jsonResponse = try JSONDecoder().decode([Statement].self, from: data)
                    completion(.success(jsonResponse))
                    print("responseString = \(jsonResponse)")
                }
                catch {
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
}
