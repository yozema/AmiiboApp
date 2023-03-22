//
//  FetchAmiibo.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 21.03.2023.
//

import Foundation

final class FetchAmiibo {
    
    static let shared = FetchAmiibo()
    
    private let amiibosURL = "https://amiiboapi.com/api/amiibo/?showusage"
    
    func fetchAmiibo() {
        guard let url = URL(string: amiibosURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let amiiboList = try decoder.decode(Amiibo.self, from: data)
                print(amiiboList.amiibo)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    private init(){}
}
