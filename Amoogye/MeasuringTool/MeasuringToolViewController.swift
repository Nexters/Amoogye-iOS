//
//  MeasuringToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeasuringToolViewController: UIViewController {

    @IBOutlet weak var toolTableView: UITableView!

    var measuringToolManager: RMMeasuringToolManager?
    var measuringToolList: [MeasuringTool]?

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self

        measuringToolList = measuringToolManager?.getMeausringToolList()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.measuringToolList = self.measuringToolManager?.getMeausringToolList()
        self.toolTableView.reloadData()
    }
}

extension MeasuringToolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measuringToolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell

        cell.toolNameLabel.text = measuringToolList?[indexPath.item].name
        cell.toolSubnameLabel.text = measuringToolList?[indexPath.item].subname
        return cell
    }
}

extension MeasuringToolViewController: UITableViewDelegate {

}
