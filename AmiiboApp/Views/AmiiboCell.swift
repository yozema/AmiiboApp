//
//  AmiiboCell.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

final class AmiiboCell: UICollectionViewCell {
    @IBOutlet var amiiboImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var gameLabel: UILabel!
    @IBOutlet var seriesLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with amiibo: Description) {
        nameLabel.text = amiibo.character
        gameLabel.text = amiibo.gameSeries
        seriesLabel.text = amiibo.amiiboSeries
        
        networkManager.fetchImage(from: amiibo.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.amiiboImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
