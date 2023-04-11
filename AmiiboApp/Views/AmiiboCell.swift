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
    
    // MARK: - Cell Configuration
    func configure(with amiibo: Description) {
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
        )
    }
}
