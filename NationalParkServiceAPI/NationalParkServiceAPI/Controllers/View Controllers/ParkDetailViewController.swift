//
//  ParkDetailViewController.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/5/22.
//

import UIKit


class ParkDetailViewController: UIViewController {
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkStateLabel: UILabel!
    @IBOutlet weak var parkCoordinatesLabel: UILabel!
    @IBOutlet weak var parkDescriptionTextView: UITextView!
    @IBOutlet weak var entranceFeeLabel: UILabel!
    @IBOutlet weak var parkFirstImage: UIImageView!
    @IBOutlet weak var parkActiviesTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let parkController = ParkController.sharedInstance
    // Reciever Property
    var parkReceiver: Park?
  
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: Helper Functions
    func updateViews() {
        guard let park = parkReceiver else {return}
        parkNameLabel.text = park.name
        parkStateLabel.text = park.states
        parkCoordinatesLabel.text = park.coordinates
        parkDescriptionTextView.text = park.description
        entranceFeeLabel.accessibilityUserInputLabels = park.entranceFees
    }
    
    func updateFavoriteButton() {
        guard let park = parkReceiver else {return}
        let favoriteImageName = park.isFavorite ? "heart.fill" : "heart"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    


    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        guard let park = parkReceiver else {return}
        parkController.toggleFavorite(park : park)
        updateFavoriteButton()
    }
    
    @IBAction func previousParkButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextParkButtonTapped(_ sender: Any) {
    }
}
