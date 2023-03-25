//
//  DescriptionViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var amiiboImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    var amiiboDescription: Description!
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = amiiboDescription.character
        descriptionLabel.text = amiiboDescription.description
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as? UINavigationController
        guard let usageVC = navigationVC?.topViewController as? UsageTableViewController else { return }
        usageVC.amiiboDescription = amiiboDescription
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
