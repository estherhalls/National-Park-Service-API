//
//  ParkListTableViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import UIKit

class ParkListTableViewController: UITableViewController {
    
    
    // Placeholder property
    var topLevel: Park?
    var parksArray: [Park] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchParks { parks in
            guard let parks else {return}
            // All UI updates must happen on main thread of Grand Central Dispatch
            DispatchQueue.main.async {
                self?.parksArray = parks
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parkCell", for: indexPath)
        let park = parksArray[indexPath.row]
        cell.textLabel?.text = "\(park.name)"
        cell.detailTextLabel?.text = "\(park.states)"
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let destinationVC = segue.destination as? ParkDetailViewController,
              if let indexPath = tableView.indexPathForSelectedRow else {return}
        // This is where we get the Park the user tapped on
        let parkToSend = parksArray[indexPath.row]
        // Fetch individual park
        NetworkController.fetchSinglePark(for: parkToSend) { <#Park?#> in
            <#code#>
        }
    }
    
} // End of Class
