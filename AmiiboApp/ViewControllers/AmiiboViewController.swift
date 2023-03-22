//
//  ViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 20.03.2023.
//

import UIKit

final class AmiiboViewController: UIViewController {
    
    private let amiibosURL = "https://amiiboapi.com/api/amiibo/?showusage"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAmiibos()
    }
    
    private func fetchAmiibos() {
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
}

