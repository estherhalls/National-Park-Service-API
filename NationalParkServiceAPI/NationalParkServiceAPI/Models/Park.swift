//
//  Park.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import Foundation
class Park {
    let name: String
    let description: String
    let parkCode: String
    let states: String
    let coordinates: String
    let directionsInfo: String
    let directionsURL: String
    let entranceFees: [String:String]
    let images: [String:String]
    let activities: [String:String]
    let url: String
    
    init(name: String, description: String, parkCode: String, states: String, coordinates: String, directionsInfo: String, directionsURL: String, entranceFees: [String : String], images: [String : String], activities: [String : String], url: String) {
        self.name = name
        self.description = description
        self.parkCode = parkCode
        self.states = states
        self.coordinates = coordinates
        self.directionsInfo = directionsInfo
        self.directionsURL = directionsURL
        self.entranceFees = entranceFees
        self.images = images
        self.activities = activities
        self.url = url
    }
    
} // End of class

extension Park {
    
    // Convenience Initializer
    convenience init?(parkDictionary: [String:Any]) {
        guard let name = parkDictionary["fullName"] as? String,
            let description = parkDictionary["description"] as? String,
            let parkCode = parkDictionary["parkCode"] as? String,
            let states = parkDictionary["states"] as? String,
            let coordinates = parkDictionary["latLong"] as? String,
            let directionsInfo = parkDictionary["directionsInfo"] as? String,
            let directionsURL = parkDictionary["directionsURL"] as? String,
            let entranceFees = parkDictionary["entranceFees"] as? [String:String],
            let images = parkDictionary["images"] as? [String:String],
            let activities = parkDictionary["activities"] as? [String:String],
            let url = parkDictionary["url"] as? String else {
                return nil }
        
        self.init(name: name, description: description, parkCode: parkCode, states: states, coordinates: coordinates, directionsInfo: directionsInfo, directionsURL: directionsURL, entranceFees: entranceFees, images: images, activities: activities, url: url)
        
    }
    
} // End of Extension


// Found online for displaying image from image URL

//import UIKit
//extension UIImageView {
//    func loadurl(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

/**
 Example of API data from top level:
 
 {
 "total": "467",
 "limit": "50",
 "start": "0",
 "data": [
 {
 "id": "77E0D7F0-1942-494A-ACE2-9004D2BDC59E",
 "url": "https://www.nps.gov/abli/index.htm",
 "fullName": "Abraham Lincoln Birthplace National Historical Park",
 "parkCode": "abli",
 "description": "For over a century people from around the world have come to rural Central Kentucky to honor the humble beginnings of our 16th president, Abraham Lincoln. His early life on Kentucky's frontier shaped his character and prepared him to lead the nation through Civil War. Visit our country's first memorial to Lincoln, built with donations from young and old, and the site of his childhood home.",
 "latitude": "37.5858662",
 "longitude": "-85.67330523",
 "latLong": "lat:37.5858662, long:-85.67330523",
 "activities": [
 {
 "id": "13A57703-BB1A-41A2-94B8-53B692EB7238",
 "name": "Astronomy"
 },
 */
