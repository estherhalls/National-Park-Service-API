//
//  ParkTableViewCell.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/7/22.
//

import UIKit

// Protocol Declaration:
protocol ParkTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonTapped (cell: ParkTableViewCell)
}
class ParkTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkStateLabel: UILabel!
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    
    
    // MARK: - Properties
    // The table view cells delegate which reports when the favorite button is tapped
    weak var delegate: ParkTableViewCellDelegate?
    // Property Observer - run if an event is triggered that changes the value of a property
    var park: Park? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    // Updates table view cells for the specific park data
    func updateViews(){
        guard let park = park else {return}
        parkNameLabel.text = park.name
        parkStateLabel.text = park.states
        
        let favoriteImageName = park.isFavorite ? "heart.fill" : "heart"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        toggleFavoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonTapped(cell: self)
    }
} // End of Class
