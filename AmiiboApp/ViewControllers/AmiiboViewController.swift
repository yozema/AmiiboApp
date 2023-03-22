//
//  ViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 20.03.2023.
//

import UIKit

final class AmiiboViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchAmiibo.shared.fetchAmiibo()
    }
}

