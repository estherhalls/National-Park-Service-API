//
//  ParkController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/7/22.
//

import Foundation

class ParkController {
    
    init() {
        loadStatus()
    }
    
    // MARK: - Singleton
    static let sharedInstance = ParkController()
    
    // MARK: - SOT
    var parks: [Park] = []
    
    
    // Helper Function:
    func toggleFavorite(park: Park) {
        park.isFavorite.toggle()
        saveStatus()
    }
    
    // MARK: - Save to Persistent Storage
    private var fileURL: URL? {
        guard let documentsDirectory =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("NPSParksStatus.json")
        return url
    }
    
    func saveStatus() {
        guard let saveLocation = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(parks)
            try data.write(to: saveLocation)
        } catch let error {
            print(error)
        }
    } // End of Save
    
    func loadStatus() {
        guard let loadLocation = fileURL else { return }
        do {
            let data = try Data(contentsOf: loadLocation)
            let decodedGroups = try JSONDecoder().decode([Park].self, from: data)
            self.parks = decodedGroups
        } catch let error {
            print(error)
        }
    } // End of Load
    
} // End of Class
