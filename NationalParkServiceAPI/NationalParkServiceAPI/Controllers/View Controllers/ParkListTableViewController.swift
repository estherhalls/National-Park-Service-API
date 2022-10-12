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
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchParks { parks in
            guard let parks = parks else {return}
            DispatchQueue.main.async {
                self.tempParks = parks
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempParks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "parkCell", for: indexPath) as? ParkTableViewCell else {return UITableViewCell()}
        let park = tempParks[indexPath.row]
        cell.updateViews()
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let destinationVC = segue.destination as? ParkDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        // This is where we get the Park the user tapped on
        let parkToSend = tempParks[indexPath.row]
        // Fetch individual park
        NetworkController.fetchSinglePark(for: parkToSend) { park in
            guard let unwrappedPark = park else {return}
            destinationVC.parkReceiver = parkToSend
        }
    }
    @IBAction func favoriteFilterSwitchTapped(_ sender: Any) {
    }
} // End of Class

extension ParkListTableViewController: ParkTableViewCellDelegate {
    func toggleFavoriteButtonTapped(cell: ParkTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let park = tempParks[indexPath.row]
        ParkController.toggleFavorite(park: park)
        cell.updateViews()
    }
}
