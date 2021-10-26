//
//  ServiceRequest.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 19/10/21.
//

import Foundation
import UIKit

enum CustomError: String, Error {
    case invalidUrl = "Erro ao conectar com a API."
    case urlEmpty = "Erro ao buscar dados na API."
    case other = "Dados inválidos ou não identificados."
}

struct ServiceRequest {
    
    func performLoginRequest(urlString: String, userLogin: String, userPassword: String, completion: @escaping (Result<User, Error>) -> Void) throws {
        
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
            } catch {return}
            print(request)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if (error != nil) {
                    completion(.failure(CustomError.invalidUrl))
                }
                print(response)
                if (response != nil) {
                    let response = response as? HTTPURLResponse
                    if (response!.statusCode > 400) {
                        completion(.failure(CustomError.urlEmpty))
                    } else if (response!.statusCode != 200) {
                        completion(.failure(CustomError.other))
                    }
                }
                do {
                    if let data = data {
                        let jsonResponse = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(jsonResponse))
                        
                    } else {
                        completion(.failure(CustomError.other))
                    }
                }
                catch {
                    completion(.failure(CustomError.other))
                }
            }
            task.resume()
        } else {
            fatalError()
        }
    }
    
    func performStatementRequest(urlString: String, userToken: String, completion: @escaping (Result<[Statement], Error>) -> Void) {
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue(userToken, forHTTPHeaderField: "token")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          print("error", error ?? "Unknown error")
                          return
                      }
                
                guard (200 ... 299) ~= response.statusCode else {
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
