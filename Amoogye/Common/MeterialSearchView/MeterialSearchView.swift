//
//  SearchView.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class MeterialSearchView: UIView {
    let cellIdentifier = "MeterialSearchResultCell"

    weak var delegate: MeterialSearchDelegate?

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTabelView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupTabelView()
    }

    func setupView() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else {
            return
        }

        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds

        searchBarView.layer.cornerRadius = 6
    }

    func setupTabelView() {
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MeterialSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MeterialSearchResultCell
        cell.resultLabel.text = String(indexPath.row + 1)+"번 재료"
        cell.delegate = self.delegate
        return cell
    }
}

extension MeterialSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectMeterial(name: String(indexPath.row + 1)+"번 재료")
        delegate?.closeSearchView()
    }
}

protocol MeterialSearchDelegate: class {
    func selectMeterial(name: String)
    func closeSearchView()
}
