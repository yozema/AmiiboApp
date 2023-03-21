//
//  Amiibo.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 20.03.2023.
//

import Foundation

struct AmiiboList: Decodable {
    let amiibo: [Amiibo]
}

struct Amiibo: Decodable {
    let amiiboSeries: String?
    let character: String?
    let gameSeries: String?
    let image: URL?
    let name: String?
    let release: Release?
    let type: String?
}

struct Release: Decodable {
    let eu: String?
}
