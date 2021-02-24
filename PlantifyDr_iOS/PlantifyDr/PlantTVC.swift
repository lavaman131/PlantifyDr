//
//  PlantTVC.swift
//  PlantifyDr
//
//  Created by Ali Lavaee on 2/22/21.
//  Copyright © 2021 Swift Creator. All rights reserved.
//

import UIKit

class PlantTVC: UITableViewCell {

    @IBOutlet weak var plantView: UIView!
    @IBOutlet weak var plantLbl: UILabel!
    @IBOutlet weak var plantImgView: UIImageView!
    @IBOutlet weak var plantButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
