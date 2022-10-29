//
//  ParkDetailViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import UIKit

// Individual park information on this view

class ParkDetailViewController: UIViewController {
    
    @IBOutlet weak var parkShortNameLabel: UILabel!
    @IBOutlet weak var parkCoordinatesLabel: UILabel!
    @IBOutlet weak var parkFirstImageImageView: UIImageView!
    @IBOutlet weak var parkCostLabel: UILabel!
    @IBOutlet weak var parkDescriptionTextView: UITextView!
    @IBOutlet weak var parkActivitiesTableView: UITableView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                parkActivitiesTableView.dataSource = self
                parkActivitiesTableView.delegate = self
    }
    // MARK: - Properties
  
    // Reciever Property
    var parkData: Park? {
        didSet {
            updateViews()
        }
    }
    
    //    var cost: String = ""
    //    var activities: [Park.activities] = []
    
    // MARK: - Helper Functions
    
    //    func hasCost() {
    //        guard let park = parkData else {return}
    //        let fees = park.entranceFees[0]
    //        if fees.cost == "0.00" {
    //            cost = "Free"
    //        } else {
    //            cost = "$\(fees.cost)"
    //        }
    //    }
    
    func updateViews() {
        guard let park = parkData else {return}
        let image = park.images[0]
        NetworkController.fetchImage(for: image) { [weak self] image in
            guard let image else {return}
            DispatchQueue.main.async {
                self?.parkShortNameLabel.text = park.parkShortName
                self?.parkCoordinatesLabel.text = park.coordinates
                self?.parkDescriptionTextView.text = park.description
                self?.parkFirstImageImageView.image = image
             
                self?.parkActivitiesTableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    /// I want to navigate forward and back based on the current park placement on the index defined on the table view controller
    /// I will need to inform this detail view of that index and current position, and what to do at the beginning and end of index (loop back to beginning? end and stop showing the button for that direction in the index?)
    /// each button will need updateViews function at the end to repopulate with new park data
    @IBAction func previousParkButtonTapped(_ sender: Any) {
    }
    @IBAction func nextParkButtonTapped(_ sender: Any) {
    }
} // End of Class

//// MARK: - Extensions
extension ParkDetailViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkData?.activities.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        let activity = parkData?.activities[indexPath.row]
        cell.textLabel?.text = activity
        return cell
    }
}
