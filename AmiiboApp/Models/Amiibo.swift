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
    let amiiboSeries: String
    let gameSeries: String
    let image: URL
    let name: String
    let character: String
    let release: Release?
    let gamesSwitch: [Console]
    let games3DS: [Console]
    let gamesWiiU: [Console]
    let type: String
    let head: String
    let tail: String
    
    var description: String{
        """
        Name: \(name)
        Game Series: \(gameSeries)
        Amiibo Series: \(amiiboSeries)
        Type: \(type)
        Identifier: \(head + tail)

        """
    }
}

struct Release: Decodable {
    let au: String?
    let jp: String?
    let eu: String?
    let na: String?
}

struct Console: Decodable {
    let gameName: String
    let amiiboUsage: [Usage]
}

struct Usage: Decodable {
    let usage: String
    
    enum CodingKeys: String, CodingKey {
        case usage = "Usage"
    }
}
