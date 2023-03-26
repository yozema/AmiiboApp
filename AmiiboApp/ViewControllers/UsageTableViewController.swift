//
//  UsageTableViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 24.03.2023.
//

import UIKit

enum Consoles: String {
    case nintendoSwitch = "Nintendo Switch"
    case nintendoWiiU = "Nintendo WiiU"
    case nintendo3DS = "Nintendo 3DS"
}

final class UsageTableViewController: UITableViewController {
    
    // MARK: - Properties
    var amiiboDescription: Description!
    
    private let networkManager = NetworkManager.shared
    private var consolesQuantity = 0
    private var gameList: [String] = []
    private var switchGames: [String] = []
    private var wiiuGames: [String] = []
    private var threeDSGames: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = amiiboDescription.name
        
        prepareGameList()
        consolesCounting()
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        consolesQuantity
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = Consoles.nintendoSwitch.rawValue
        case 1:
            sectionName = Consoles.nintendoWiiU.rawValue
        default:
            sectionName = Consoles.nintendo3DS.rawValue
        }
        return sectionName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionRows: Int
        switch section {
        case 0:
            sectionRows = switchGames.count
        case 1:
            sectionRows = wiiuGames.count
        default:
            sectionRows = threeDSGames.count
        }
        return sectionRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameUse", for: indexPath)
        var content = cell.defaultContentConfiguration()
        cell.contentConfiguration = content
        switch indexPath.section {
        case 0:
            content.text = switchGames[indexPath.row]
        case 1:
            content.text = wiiuGames[indexPath.row]
        default:
            content.text = threeDSGames[indexPath.row]
        }
        cell.contentConfiguration = content

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Private functions
    private func prepareGameList() {
        switchGames = amiiboDescription.gamesSwitch.map { $0.gameName }
        wiiuGames = amiiboDescription.gamesWiiU.map { $0.gameName }
        threeDSGames = amiiboDescription.games3DS.map { $0.gameName }
    }
    
    private func consolesCounting() {
        for item in amiiboDescription.consoles {
            consolesQuantity += item
        }
    }
}
