//
//  MeasuringToolViewController + UITableView.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension MeasuringToolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.measuringToolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell
        let index = indexPath.item

        cell.delegate = self

        cell.separatorInset = UIEdgeInsets.zero
        cell.setup(tool: self.measuringToolList![index], index: index)

        if isToolEdited {
            cell.showEditButton()
        } else {
            cell.hideEditButton()
        }

        return cell
    }
}

extension MeasuringToolViewController: UITableViewDelegate {

}

extension MeasuringToolViewController: MeasuringToolTableViewCellDelegate {
    func didOnoffButton(_ tag: Int, isOn: Bool) {
        if var measuringTool = self.measuringToolList?[tag] {
            measuringTool.isOn = isOn
            self.measuringToolManager?.updateMeasuringTool(measuringTool)
        }
    }

    func addCellItem(index: Int) {
        let toolList = self.measuringToolManager?.getMeasuringToolList().filter {
            $0.toolType == .living
        }
        guard let tool = toolList?[index] else {
            return
        }
        self.selectedToolList?.append(tool)
    }

    func removeCellItem(index: Int) {
        let toolList = self.measuringToolManager?.getMeasuringToolList().filter {
            $0.toolType == .living
        }
        guard let tool = toolList?[index] else {
            return
        }

        for (index, item) in self.selectedToolList!.enumerated() {
            if tool.name == item.name {
                self.selectedToolList?.remove(at: index)
            }
        }
    }
}
