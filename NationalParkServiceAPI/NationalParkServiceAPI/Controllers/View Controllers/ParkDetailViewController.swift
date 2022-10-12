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
    
    // Reciever Property
    
    var parkData: ParkData? {
        didSet {
            updateViews()
        }
    }
    
    var fees: [FeeDetails] = []
    var addresses: [ParkAddress] = []
    var images: [Image] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    
    // MARK: - Helper Functions
    func setupTable() {
        parkActivitiesTableView.delegate = self
        parkActivitiesTableView.dataSource = self
    }
    
    func updateViews() {
        guard let park = parkData else {return}
        let image = images[0]
        let address = addresses[0]
        let fees = fees[0]
        
        NetworkController.fetchImage(for: image.imageURL) { [weak self] result in
            switch result {
            case.success(let image):
                
                DispatchQueue.main.async {
                    self?.parkNameLabel.text = park.name
                    self?.parkCityNameLabel.text = address.city
                    self?.parkStateLabel.text = address.stateCode
                    self?.parkCoordinatesLabel.text = park.coordinates
                    self?.parkDescriptionTextView.text = park.description
                    self?.entranceFeeLabel.text = fees.cost
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
extension ParkDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
}
