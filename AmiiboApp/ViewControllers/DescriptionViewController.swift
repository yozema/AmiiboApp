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
    @IBOutlet var countriesSegmentControl: UISegmentedControl!
    @IBOutlet var dateReleaseLabel: UILabel!
    

    // MARK: - Properties
    var amiiboDescription: Description!
    private let networkManager = NetworkManager.shared
    private var countries: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDisplaySetup()
        fetchImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as? UINavigationController
        guard let usageVC = navigationVC?.topViewController as? UsageTableViewController else { return }
        usageVC.amiiboDescription = amiiboDescription
    }
    
    // MARK: - IBActions
    @IBAction func releaseDateSegmentAction() {
        switch countriesSegmentControl.selectedSegmentIndex {
        case 0:
            dateReleaseLabel.text = (amiiboDescription.release?.au ?? "").isEmpty
            ? "N/A"
            : amiiboDescription.release?.au
        case 1:
            dateReleaseLabel.text = (amiiboDescription.release?.eu ?? "").isEmpty
            ? "N/A"
            : amiiboDescription.release?.eu
        case 2:
            dateReleaseLabel.text = (amiiboDescription.release?.jp ?? "").isEmpty
            ? "N/A"
            : amiiboDescription.release?.jp
        default:
            dateReleaseLabel.text = (amiiboDescription.release?.na ?? "").isEmpty
            ? "N/A"
            : amiiboDescription.release?.na
        }
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
    
    private func startDisplaySetup() {
        title = amiiboDescription.character
        descriptionLabel.text = amiiboDescription.description
        dateReleaseLabel.text = (amiiboDescription.release?.au ?? "").isEmpty
        ? "N/A"
        : amiiboDescription.release?.au
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
