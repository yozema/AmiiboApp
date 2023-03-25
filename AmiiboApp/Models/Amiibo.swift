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
    let gamesSwitch: [Console]
    let gamesWiiU: [Console]
    let games3DS: [Console]
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
    var consoles: [Int] {
        [gamesSwitch.isEmpty ? 0 :1 , gamesWiiU.isEmpty ? 0: 1, gamesWiiU.isEmpty ? 0: 1]
    }
}

struct Console: Decodable {
    let gameName: String
}


