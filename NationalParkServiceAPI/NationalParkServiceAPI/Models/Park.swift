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
    let entranceFees: [String]
    let images: [String]
    let activities: [String]
  
  
    
    // Designated Initializer
    /// The memberwise initializer required for a class
    init(name: String, description: String, parkCode: String, states: String, coordinates: String,  entranceFees: [String], images: [String], activities: [String]) {
        self.name = name
        self.description = description
        self.parkCode = parkCode
        self.states = states
        self.coordinates = coordinates
        self.entranceFees = entranceFees
        self.images = images
        self.activities = activities
       
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
              let entranceFeesArray = parkDictionary["entranceFees"] as? [[String:String]],
              let imagesArray = parkDictionary["images"] as? [[String:String]],
              let activitiesArray = parkDictionary["activities"] as? [[String:String]] else {
            return nil }
        
        // Entrance Fees:
        // Temp Array
        var tempFeesArray: [String] = []
        // Second Level:
        /// if the dictionary is in an array, it needs a for-in loop
        for feeDictionary in entranceFeesArray {
            // Third Level:
            guard let parkCost = feeDictionary["cost"] else {return nil}
            /// Break the string out of the for-in loop by appending to array
            tempFeesArray.append(parkCost)
        }

        // Images Array:
        var tempImagesArray: [String] = []
        for imageDictionary in imagesArray {
            guard let imageURL = imageDictionary["url"] else {return nil}
            tempImagesArray.append(imageURL)
        }
        
        // Activities Array:
        var tempActivitiesArray: [String] = []
        for activityDictionary in activitiesArray {
            guard let activityName = activityDictionary["name"] else {return nil}
            tempActivitiesArray.append(activityName)
        }
        
        /// Convenience intializers must still call the designated initializer
        self.init(name: name, description: description, parkCode: parkCode, states: states, coordinates: coordinates, entranceFees: tempFeesArray, images: tempImagesArray, activities: tempActivitiesArray)
        
    }
}

//{
//    "abilities": [
//        {
//            "ability": {
//                "name": "overgrow",
//                "url": "https://pokeapi.co/api/v2/ability/65/"
//            },
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
