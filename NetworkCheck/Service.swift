//
//  File.swift
//  NetworkCheck
//
//  Created by Andrew Kolbasov on 20.02.2021.
//

import Foundation
import UIKit

class Service: NSObject {
    static let shared = Service()
    
    func getRequestWithURLSession(completion: @escaping (Result<[Human], Error>) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let human = try JSONDecoder().decode([Human].self, from: data)
                    completion(.success(human))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
