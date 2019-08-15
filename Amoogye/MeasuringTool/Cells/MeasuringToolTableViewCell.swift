//
//  MeasuringToolTableViewCell.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasuringToolTableViewCell: UITableViewCell {

    var delegate: MeasuringToolTableViewCellDelegate?

    @IBOutlet weak var toolNameLabel: UILabel!
    @IBOutlet weak var toolSubnameLabel: UILabel!
    @IBOutlet weak var onoffButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickOnoffButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        setButtonImage(sender.isSelected)
        delegate?.didOnoffButton(sender.tag, isOn: sender.isSelected)
    }

    func setButtonImage(_ selected: Bool) {
        if selected {
            self.onoffButton.setImage(UIImage(named: "onButton"), for: .normal)
        } else {
            self.onoffButton.setImage(UIImage(named: "offButton"), for: .normal)
        }
    }
}
