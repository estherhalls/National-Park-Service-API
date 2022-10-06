//
//  Park.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import Foundation
class Park {
    var total: String
    
} // End of class

import UIKit

extension UIImageView {
    func loadurl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
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
