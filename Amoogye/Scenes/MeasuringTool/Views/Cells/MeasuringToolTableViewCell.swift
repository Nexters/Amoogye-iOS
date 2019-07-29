//
//  MeasuringToolTableViewCell.swift
//  Amoogye
//
//  Created by 임수현 on 29/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasuringToolTableViewCell: UITableViewCell {

    @IBOutlet weak var toolNameLabel: UILabel!
    @IBOutlet weak var toolSubnameLabel: UILabel!
    @IBOutlet weak var toolSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
