//
//  NetworkController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import UIKit

struct NetworkController {

    // MARK: - URL
    // Base URL
    private static let baseURLString = "https://developer.nps.gov/api/v1"
    
    // Keys for URL Components
    private static let kParksComponent = "parks"
    private static let kAPIKeyKey = "api_key"
    private static let kAPIKeyValue = "zo5biGMft4UFbCYYBK8TCqv9AXKjqlKEjFTaKrxS"
    private static let kParkCodeKey = "parkCode"
    private static let kLimitKey = "limit"
    private static let kLimitValue = "500"
    
    static func fetchParks(completion: @escaping ([Park]?) -> Void) {
        // Step 1: Get URL
        guard let baseURL = URL(string: baseURLString) else {
            completion(nil)
            return
        }
        // Compose final URL
        let parksURL = baseURL.appendingPathComponent(kParksComponent)
        /// Add Query items with URLComponent Struct
        var urlComponents = URLComponents(url: parksURL, resolvingAgainstBaseURL: true)
        
        // Query item
        let apiKeyQuery = URLQueryItem(name: kAPIKeyKey, value: kAPIKeyValue)
        let limitQuery = URLQueryItem(name: kLimitKey, value: kLimitValue)
        urlComponents?.queryItems = [apiKeyQuery, limitQuery]
        
        guard let finalURL = urlComponents?.url else {
            completion(nil)
            return
        }
        print (finalURL)
  
        // Step 2: Start a dataTask to retrieve data
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            /// Handle error first, new Xcode syntax does not require "error = error"
            if let error {
                /// New syntax for string interpolation
                print("🤬🤬🤬 There was an error with the data task", error.localizedDescription)
                completion(nil)
                return
            }
            // Check for Data
            guard let parkData = dTaskData else {
                print("🤬🤬🤬 There was an error with the data check")
                completion(nil)
                return
            }
            // Convert to JSON (do,try,catch)
            do {
                guard let topLevelDictionary = try? JSONSerialization.jsonObject(with: parkData, options: .fragmentsAllowed) as? [String:Any],
                      let dataArray = topLevelDictionary["data"] as? [[String:Any]] else {completion(nil); return}
                /// Access Data one at a time with for-in loop
                var tempArray: [Park] = []
                for dataDictionary in dataArray {
                    guard let park = Park(parkDictionary:dataDictionary) else {
                        completion(nil); return }
                    tempArray.append(park)
                }
                // Completion returns an array of parks
                completion(tempArray)
            }
            // Resume starts dataTask and continues it. Tasks begin in suspended state.
        }.resume()
    } // End of Network Call
    
    // Network Call to fetch individual park data
    static func fetchSinglePark(with parkCode: String, completion: @escaping(Park?) -> Void) {
        // Step 1: Get URL
        // failable initializer has to be unwrapped (guard let)
        guard let baseURL = URL(string: baseURLString) else { completion(nil); return }
        // Compose final URL
        let parksURL = baseURL.appendingPathComponent(kParksComponent)
        
        /// Add Query items with URLComponent Struct
        var urlComponents = URLComponents(url: parksURL, resolvingAgainstBaseURL: true)

        /// Query item
        let apiKeyQuery = URLQueryItem(name: kAPIKeyKey, value: kAPIKeyValue)
        let parkCodeQuery = URLQueryItem(name: kParkCodeKey, value: parkCode)
        urlComponents?.queryItems = [apiKeyQuery, parkCodeQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil); return }
        print (finalURL)
        
        // Step 2: Start a dataTask to retrieve data
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            /// Handle error first, new Xcode syntax does not require "error = error"
            if let error {
                /// New syntax for string interpolation
                print("🤬🤬🤬 There was an error with the data task", error.localizedDescription)
                completion(nil)
                return
            }
            // Check for Data
            guard let parkData = dTaskData else {
                print("🤬🤬🤬 There was an error with the data check")
                completion(nil)
                return }
            // Convert to JSON (do,try,catch)
            do {
                guard let park = try? JSONSerialization.jsonObject(with: parkData, options: .fragmentsAllowed) as? [String:Any] else {completion(nil); return}
                
                let parkDetails = Park(parkDictionary: park)
                // returns a single park
                completion(parkDetails)
            }
            // Resume starts dataTask and continues it. Tasks begin in suspended state.
        }.resume()
        
    }// End of Network Call 2
    
    // Getting images from the internet requires network call with completion handler
    /// Remember to Import UIKit at top of file
   static func fetchImage(for imageURL: String, completion: @escaping (UIImage?) -> Void) {
        // Step 1 - Construct URL
        guard let url = URL(string: imageURL) else {completion(nil); return}
        
        //Step 2 - DataTask
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("🤬🤬🤬 There was an error with the image data task", error.localizedDescription)
                completion(nil); return}
            ///guard let needs to return
            guard let imageData = data else {completion(nil); return}
            guard let parkImage = UIImage(data: imageData) else {completion(nil); return}
            completion(parkImage)
            
        }.resume()
    } // End of Network Call 3
} // End of Struct
