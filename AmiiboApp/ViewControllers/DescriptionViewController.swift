//
//  DescriptionViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet var amiiboImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var amiiboDescription: Description!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = amiiboDescription.character
        descriptionLabel.text = amiiboDescription.description
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    

    // MARK: - Private Functions
    private func fetchImage() {
        networkManager.fetchImage(from: amiiboDescription.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.amiiboImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
