//
//  ParkTableViewCell.swift
//  NationalParkServiceAPI
//
//  Created by Esther on 10/7/22.
//

import UIKit

class ParkTableViewCell: UITableViewCell {

    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkStateLabel: UILabel!
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
    }
} // End of Class
