//
//  MeterialSearchResultCell.swift
//  Amoogye
//
//  Created by 임수현 on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialSearchResultCell: UITableViewCell {

    weak var delegate: MeterialSearchDelegate?

    @IBOutlet weak var resultLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func selectButtonClick(_ sender: Any) {
        guard let selectedMeterialName = resultLabel.text else {
            return
        }
        delegate?.selectMeterial(name: selectedMeterialName)
        delegate?.closeSearchView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
