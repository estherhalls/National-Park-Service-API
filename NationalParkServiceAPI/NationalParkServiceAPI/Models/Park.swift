//
//  Park.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import Foundation

/// In NPS API, TLD contains "data": an array of dictionaries, each dictionary containing all data for a single park. Not like Pokemon app where a different URL was required to access individual data. Here it all exists at this endpoint, but using the parkCode in the URL you can filter down to only display data for one and not many
class Park: Codable {
    let name: String
    let description: String
    /// parkCode is required in URL to access information for only a single park
    let parkCode: String
    let states: String
    let coordinates: String
    let directionsInfo: String
    let directionsURL: String
    let entranceFees: [String]
    let images: [String]
    let activities: [String]
    let url: String
  
    
    // Designated Initializer
    /// The memberwise initializer required for a class
    init(name: String, description: String, parkCode: String, states: String, coordinates: String, directionsInfo: String, directionsURL: String, entranceFees: [String], images: [String], activities: [String], url: String) {
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
              let directionsURL = parkDictionary["directionsUrl"] as? String,
              let url = parkDictionary["url"] as? String,
              let entranceFeesArray = parkDictionary["entranceFees"] as? [[String:Any]],
              let imagesArray = parkDictionary["images"] as? [[String:Any]],
              let activitiesArray = parkDictionary["activities"] as? [[String:Any]] else {
            return nil }
        
        // Entrance Fees:
        //Temp Array
        var tempFeesArray: [String] = []
        // Second Level:
        for feeDictionary in entranceFeesArray {
            // Third Level
            guard let deeperFeeDictionary = feeDictionary["entranceFees"] as? [String:String],
                  // Fourth Level (this must be broken out with tempArray, then appended
                  let cost = deeperFeeDictionary["cost"] else {return nil}
            //            let description = deeperFeeDictionary["description"],
            //            let title = deeperFeeDictionary["title"] else {return nil}
            tempFeesArray.append(cost)
        }
        
        // Images Array:
        var tempImagesArray: [String] = []
        for imagesDictionary in imagesArray {
            guard let deeperImagesDictionary = imagesDictionary["images"] as? [String:String],
                  let imageURL = deeperImagesDictionary["url"] else {return nil}
            tempImagesArray.append(imageURL)
        }
        
        // Activities Array:
        var tempActivitiesArray: [String] = []
        for activitiesDictionary in activitiesArray {
            guard let deeperActivitiesDictionary = activitiesDictionary["activities"] as? [String:String],
                  let name = deeperActivitiesDictionary["name"] else {return nil}
            tempActivitiesArray.append(name)
            
        }
        /// Convenience intializers must still call the designated initializer
        self.init(name: name, description: description, parkCode: parkCode, states: states, coordinates: coordinates, directionsInfo: directionsInfo, directionsURL: directionsURL, entranceFees: tempFeesArray, images: tempImagesArray, activities: tempActivitiesArray, url: url)
        
    }
}
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
