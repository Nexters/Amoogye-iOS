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

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self
    }
}

extension MeasuringToolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell
        
        cell.toolNameLabel.text = "단위"
        cell.toolSubnameLabel.text = "부단위"
        return cell
    }
}

extension MeasuringToolViewController: UITableViewDelegate {

}
