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
    
    var parkReceiver: Park?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    @IBAction func parkWebsiteURLButtonTapped(_ sender: Any) {
    }
    @IBAction func previousParkButtonTapped(_ sender: Any) {
    }
    @IBAction func nextParkButtonTapped(_ sender: Any) {
    }
}
