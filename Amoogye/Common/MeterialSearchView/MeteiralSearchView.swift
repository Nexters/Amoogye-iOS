//
//  MeteiralSearchVIew.swift
//  Amoogye
//
//  Created by 임수현 on 01/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialSearchView: UIView {

    weak var delegate: MeterialPickerDelegate?
    @IBOutlet weak var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    func initializeSubviews() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            return
        }

        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds

        setupTableView()
    }

    func setupTableView() {
        let nibCell = UINib(nibName: "MeterialSearchResultCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "MeterialSearchResultCell")

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MeterialSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectMeterial(name: String(indexPath.row + 1)+"번 재료")
        delegate?.closeMeterialSearchView()
    }
}

extension MeterialSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MeterialSearchResultCell", for: indexPath) as! MeterialSearchResultCell
        cell.resultLabel.text = String(indexPath.row + 1)+"번 재료"
        cell.delegate = self.delegate

        return cell
    }
}
