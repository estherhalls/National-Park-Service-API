//
//  ParkListTableViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import UIKit

class ParkListTableViewController: UITableViewController {
    
    // Placeholder property
    var tempParks: [Park] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkController.fetchParks { parks in
            guard let parks = parks else {
                return
            }
            DispatchQueue.main.async {
                self.tempParks = parks
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempParks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parkCell", for: indexPath)
        let park = tempParks[indexPath.row]
        cell.textLabel?.text = park.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let destinationVC = segue.destination as? ParkDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return }
        
        // This is where we get the Park the user tapped on
        let parkToSend = tempParks[indexPath.row]
        
            destinationVC.parkReceiver = parkToSend
        
                
    }

} // End of Class
