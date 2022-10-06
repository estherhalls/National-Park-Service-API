//
//  NetworkController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import Foundation

class NetworkController {
    
    // MARK: - URL
    // Base URL
    private static let baseURL = "https://developer.nps.gov/api/v1"
    
    // Keys for URL Components
    private static let kParksComponent = "parks"
    private static let kAPIKeyKey = "api_key"
    private static let kAPIKeyValue = "zo5biGMft4UFbCYYBK8TCqv9AXKjqlKEjFTaKrxS"
    
    static func fetchParks(completion: @escaping ([Park]?) -> Void) {
        // Step 1: Get URL
        guard let baseURL = URL(string: baseURL) else {
            completion(nil)
            return
        }
        // Compose final URL
        let parksURL = baseURL.appendingPathComponent(kParksComponent)
        /// Add Query items with URLComponent Struct
        var urlComponents = URLComponents(url: parksURL, resolvingAgainstBaseURL: true)
        
        /// Query item
        let queryItem = URLQueryItem(name: kAPIKeyKey, value: kAPIKeyValue)
        urlComponents?.queryItems = [queryItem]
        
        guard let finalURL = urlComponents?.url else {
            completion(nil)
            return
        }
        print (finalURL)
        
        // Step 2: Start a dataTask to retrieve data
        URLSession.shared.dataTask(with: finalURL) { parkData, _, error in
            /// Handle error first, new Xcode syntax does not require "error = error"
            if let error {
                /// New syntax for string interpolation
                print("🤬🤬🤬 There was an error with the data task", error.localizedDescription)
                completion(nil)
                return
            }
            // Check for Data
            guard let data = parkData else {
                print("🤬🤬🤬 There was an error with the data check")
                completion(nil)
                return
            }
            // Convert to JSON (do,try,catch)
            do {
                guard let topLevelDictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any] else {
                    completion(nil)
                    return
                }
               if let data = topLevelDictionary["data"] as? [[String:Any]] {
                    var tempArray: [Park] = []
                    for dataDictionary in data {
                        guard let park = Park(parkDictionary:dataDictionary) else {
                            completion(nil)
                            return
                        }
                        tempArray.append(park)
                    }
                    completion(tempArray)
                }
            }
            
        }.resume()
        
    } // End of Network Call

} // End of Class
