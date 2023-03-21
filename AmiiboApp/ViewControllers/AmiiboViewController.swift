//
//  ViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 20.03.2023.
//

import UIKit

class AmiiboViewController: UIViewController {
    
    private let amiibosURL = "https://amiiboapi.com/api/amiibo"

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
                let amiiboList = try decoder.decode(AmiiboList.self, from: data)
                print(amiiboList.amiibo)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

