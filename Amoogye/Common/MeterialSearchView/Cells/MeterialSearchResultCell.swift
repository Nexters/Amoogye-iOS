//
//  MeterialSearchResultCell.swift
//  Amoogye
//
//  Created by 임수현 on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialSearchResultCell: UITableViewCell {

    weak var delegate: MeterialPickerDelegate?

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func clickSelectButton(_ sender: Any) {
        delegate?.selectMeterial(name: resultLabel.text ?? "")
        delegate?.closeMeterialSearchView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
