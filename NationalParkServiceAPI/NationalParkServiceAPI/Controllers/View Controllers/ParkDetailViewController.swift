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
    @IBOutlet weak var activitiesLabel: UILabel!
    @IBOutlet weak var parkFirstImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
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
        activitiesLabel.accessibilityUserInputLabels = park.activities
    }
    
    func updateFavoriteButton() {
        guard let park = parkReceiver else {return}
        let favoriteImageName = park.isFavorite ? "heart.fill" : "heart"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.image = favoriteImage
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

    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        guard let park = parkReceiver else {return}
        ParkController.toggleFavorite(park:park)
        updateFavoriteButton()
    }
    @IBAction func parkWebsiteURLButtonTapped(_ sender: Any) {
    }
    @IBAction func previousParkButtonTapped(_ sender: Any) {
    }
    @IBAction func nextParkButtonTapped(_ sender: Any) {
    }
}
