//
//  SearchTableViewCell.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        titleLabel.text = "Montreal"
        locationTypeLabel.text = "City"
    }
    
}
