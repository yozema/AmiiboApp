//
//  AmiiboCell.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit
import Kingfisher

final class AmiiboCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet var amiiboImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var gameLabel: UILabel!
    @IBOutlet var seriesLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
//    private let networkManager = NetworkManager.shared
    
    // MARK: - Cell Configuration
    func configure(with amiibo: Description) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        nameLabel.text = amiibo.character
        gameLabel.text = amiibo.gameSeries
        seriesLabel.text = amiibo.amiiboSeries
        
        amiiboImage.kf.indicatorType = .activity
        let processor = DownsamplingImageProcessor(size: amiiboImage.bounds.size)
        amiiboImage.kf.setImage(
            with: amiibo.image,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
//        networkManager.fetchImage(from: amiibo.image) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.amiiboImage.image = UIImage(data: imageData)
//                self?.activityIndicator.stopAnimating()
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
