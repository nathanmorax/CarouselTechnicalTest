//
//  APIService.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 18/04/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func fetchTv(completion: @escaping(Response?, Error?) -> ()) {
        let urlString = "https://tiradodev.github.io/appLite/pruebaAzteca.json"
        fetchDataGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchUrlWebView(urlString: String, completion: @escaping(ResponseUrlTv?, Error?) -> ()) {
        fetchDataGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchDataGeneric<T: Decodable>(urlString: String, completion: @escaping(T?, Error?) ->()) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                print("Data: ", String(decoding: data, as: UTF8.self))
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                print("decoding error:", error)
                completion(nil, error)
            }
            
        }.resume()
    }
}
