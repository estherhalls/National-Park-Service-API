//
//  ParkListTableViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/6/22.
//

import UIKit

class ParkListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var filterFavoritesSegmentedControl: UISegmentedControl!
    
    // Placeholder property
    let parkController = ParkController.sharedInstance?
    
    private var filterFavorites: [Park] {
        if filterFavoritesSegmentedControl.selectedSegmentIndex == 1 {
            return parkController?.parks.filter { $0.isFavorite } ?? []
        } else {
            return parkController?.parks ?? []
        }
    }
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchParks { parks in
            guard let parks = parks else {return}
            DispatchQueue.main.async {
                self.parkController = parks
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkController.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "parkCell", for: indexPath) as? ParkTableViewCell else {return UITableViewCell()}
        let park = parkController[indexPath.row]
        cell.updateViews()
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let destinationVC = segue.destination as? ParkDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        // This is where we get the Park the user tapped on
        let parkToSend = parkController[indexPath.row]
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
        let park = parkController[indexPath.row]
        parkController.toggleFavorite(park: park)
        cell.updateViews()
    }
}
