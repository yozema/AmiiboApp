//
//  Amiibo.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 20.03.2023.
//

import Foundation

struct Amiibo: Decodable {
    let amiibo: [Description]
}

struct Description: Decodable {
    let image: URL
    let name: String
    let release: Release?
    let gamesSwitch: [Switch]
}

struct Release: Decodable {
    let eu: String?
}

struct Switch: Decodable {
    let gameName: String
}
