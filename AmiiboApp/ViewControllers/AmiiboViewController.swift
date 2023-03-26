//
//  AmiiboViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

final class AmiiboViewController: UICollectionViewController {
    // MARK: - Properties
    private var amiibos: [Description] = []
    private let networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Amiibo Library"
        fetchAmiibo()
        showSpinner(in: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? Description else { return }
        if segue.identifier == "showDescription" {
            guard let descriptionVC = segue.destination as? DescriptionViewController else { return }
            descriptionVC.amiiboDescription = item
        }
    }
    
    // MARK: - Private Functions
    private func fetchAmiibo() {
        networkManager.fetch(Amiibo.self, from: Link.amiibosURL.url) { [weak self] result in
            switch result {
            case .success(let amiiboList):
                self?.amiibos = amiiboList.amiibo
                self?.collectionView.reloadData()
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAmiibo = amiibos[indexPath.item]
        self.performSegue(withIdentifier: "showDescription", sender: selectedAmiibo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AmiiboViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
    }
}
