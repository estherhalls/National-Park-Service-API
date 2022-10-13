//
//  ParkDetailViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import UIKit

// Individual park information on this view

class ParkDetailViewController: UIViewController {
    
    @IBOutlet weak var parkCityNameLabel: UILabel!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkStateLabel: UILabel!
    @IBOutlet weak var parkCoordinatesLabel: UILabel!
    @IBOutlet weak var parkDescriptionTextView: UITextView!
    @IBOutlet weak var entranceFeeLabel: UILabel!
    @IBOutlet weak var parkFirstImage: UIImageView!
    @IBOutlet weak var parkActivitiesTableView: UITableView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        parkActivitiesTableView.dataSource = self
 
    }
    
    // Reciever Property
    
    var parkData: ParkData? {
        didSet {
            updateViews()
        }
    }
    var cost: String = ""
 
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let park = parkData else {return}
        let image = park.images[0]
        let address = park.addresses[0]
        let fees = park.entranceFees[0]
        
        func hasCost() {
            if fees.cost == "0.00" {
                cost = "Free"
            } else {
                cost = "$\(fees.cost)"
            }
        }
        
        NetworkController.fetchImage(for: image.imageURL) { [weak self] result in
            switch result {
            case.success(let image):
                
                DispatchQueue.main.async {
                  hasCost()
                    self?.parkNameLabel.text = park.shortName
                    self?.parkCityNameLabel.text = address.city
                    self?.parkStateLabel.text = address.stateCode
                    self?.parkCoordinatesLabel.text = park.coordinates
                    self?.parkDescriptionTextView.text = park.description
                    self?.entranceFeeLabel.text = self?.cost
                    self?.parkFirstImage.image = image
                }
            case .failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
    
    
    
    // Found online for displaying image from image URL
    //    let urlYourURL = URL (string: "home_new.png")
    //
    //    avatarImageView.loadurl(url: urlYourURL!)
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

    @IBAction func parkWebsiteURLButtonTapped(_ sender: Any) {
    }
    @IBAction func previousParkButtonTapped(_ sender: Any) {
    }
    @IBAction func nextParkButtonTapped(_ sender: Any) {
    }
}

// MARK: - Extensions
extension ParkDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkData?.activities.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        guard let park = parkData else {return UITableViewCell() }
        let activity = park.activities[indexPath.row].activityName
        cell.textLabel?.text = activity
        return cell
    }
}
