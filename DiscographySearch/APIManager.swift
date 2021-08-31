//
//  APIManager.swift
//  DiscographySearch
//
//  Created by Sul S. on 8/31/21.
//

import Foundation

class APIManager {
    typealias CompletionHandler = ((Any?, Error?)->())?
    static let shared = APIManager.init()
    private init() {}
    
    func get<T>(url: URL, type: T.Type, completionHandler: CompletionHandler) where T: Decodable {
        var req = URLRequest.init(url: url)
        req.timeoutInterval = 100
        req.httpMethod = "GET"
        URLSession.shared.dataTask(with: req) { data, res, err in
            DispatchQueue.main.async {
                if data != nil && err == nil {
                    let decoder = JSONDecoder.init()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try! decoder.decode(type, from: data!)
                    completionHandler?(model, err)
                } else {
                    completionHandler?(nil, err)
                }
            }
        }.resume()
    }
}
