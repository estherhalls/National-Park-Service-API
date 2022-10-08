//
//  ParkListTableViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import UIKit

class ParkListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteFilterSwitch: UISwitch!
    
    // Placeholder property
    var tempParks: [Park] = []
    var parkReciever: Park?
    
    private var filterFavorites: [Park]{
        return favoriteFilterSwitch.isOn ? parkReciever?.filter { $0.isFavorite}
        ?? [] : parkReciever? ?? []
    }
    
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
    // MARK: - Lifecycle Methods
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempParks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "parkCell", for: indexPath) as? ParkTableViewCell else {return UITableViewCell()}
        let park = tempParks[indexPath.row]
        cell.updateViews(park: park)
        cell.delegate = self
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
    
    @IBAction func favoriteFilterSwitchTapped(_ sender: Any) {
    }
} // End of Class
