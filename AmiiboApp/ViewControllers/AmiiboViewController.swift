//
//  AmiiboViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

final class AmiiboViewController: UICollectionViewController {
    private var amiibos: [Description] = []
    private let networkManager = NetworkManager.shared

    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Amiibo Library"
        fetchAmiibo()
    }
    
    
    private func fetchAmiibo() {
        networkManager.fetch(Amiibo.self, from: Link.amiibosURL.url) { [weak self] result in
            switch result {
            case .success(let amiiboList):
                self?.amiibos = amiiboList.amiibo
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AmiiboViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        amiibos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amiiboCell", for: indexPath)
        guard let cell = cell as? AmiiboCell else { return UICollectionViewCell() }
        let amiibo = amiibos[indexPath.item]
        cell.configure(with: amiibo)
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension AmiiboViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
    }
}
