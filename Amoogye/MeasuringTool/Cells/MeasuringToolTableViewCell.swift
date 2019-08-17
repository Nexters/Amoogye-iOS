//
//  MeasuringToolTableViewCell.swift
//  Amoogye
//
//  Created by 임수현 on 30/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class MeasuringToolTableViewCell: UITableViewCell {

    var delegate: MeasuringToolTableViewCellDelegate?

    // Measuring Tool Label
    @IBOutlet weak var toolNameLabel: UILabel!
    @IBOutlet weak var toolSubnameLabel: UILabel!

    // Buttons
    @IBOutlet weak var onoffButton: UIButton!
    var selectButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectButton = UIButton()
        self.addSubview(self.selectButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - On/Off Button
    @IBAction func clickOnoffButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        setOnoff(sender.isSelected)
        delegate?.didOnoffButton(sender.tag, isOn: sender.isSelected)
    }

    // MARK: - Select Button
    @objc func clickSelectButton(sender: UIButton!) {
        sender.isSelected = !sender.isSelected

        setSelection(sender.isSelected)

        if sender.isSelected {
            delegate?.addCellItem(index: sender.tag)
        } else {
            delegate?.removeCellItem(index: sender.tag)
        }
    }
}

// MARK: - Setup Cell
extension MeasuringToolTableViewCell {
    func setup(tool: MeasuringTool, index: Int) {
        setupLabels(tool: tool)
        setupOnoffButton(index: index, isOn: tool.isOn)
        setupSelectButton(index: index, isEditable: tool.isEditable)
    }

    private func setupLabels(tool: MeasuringTool) {
        self.toolNameLabel.text = tool.name
        self.toolSubnameLabel.text = tool.subname
    }

    private func setupOnoffButton(index: Int, isOn: Bool) {
        // This will be set by Storyboard
        self.onoffButton.tag = index

        setOnoff(isOn)
    }

    private func setupSelectButton(index: Int, isEditable: Bool) {
        if isEditable {
            self.selectButton.setImage(UIImage(named: "toolSelectionOff"), for: .normal)

            self.selectButton.addTarget(self, action: #selector(clickSelectButton), for: .touchUpInside)

            self.selectButton.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
                make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            }

            self.selectButton.tag = index

            setSelection(false)
        }
    }
}

// MARK: - On/Off Button
extension MeasuringToolTableViewCell {
    func setOnoff(_ selected: Bool) {
        self.onoffButton.isSelected = selected

        if selected {
            self.onoffButton.setImage(UIImage(named: "onButton"), for: .normal)
        } else {
            self.onoffButton.setImage(UIImage(named: "offButton"), for: .normal)
        }
    }
}

// MARK: - Edit Button
extension MeasuringToolTableViewCell {
    func showEditButton() {
        self.onoffButton.isHidden = true
        self.selectButton.isHidden = false
    }

    func hideEditButton() {
        self.selectButton.isHidden = true
        self.onoffButton.isHidden = false
    }
}

// MARK: - Select Button
extension MeasuringToolTableViewCell {
    func setSelection(_ selected: Bool) {
        self.selectButton.isSelected = selected

        if selected {
            self.selectButton.setImage(UIImage(named: "toolSelectionOn"), for: .normal)
        } else {
            self.selectButton.setImage(UIImage(named: "toolSelectionOff"), for: .normal)
        }
    }
}
