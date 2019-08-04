//
//  SearchView.swift
//  Amoogye
//
//  Created by 임수현 on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SearchView: UIView {

    weak var delegate: MeterialSearchDelegate?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    func setupMeterialSearchResultView() {
        let nibCell = UINib(nibName: "MeterialSearchResultCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "MeterialSearchResultCell")

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SearchView: UITableViewDataSource {
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

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectMeterial(name: String(indexPath.row + 1)+"번 재료")
        delegate?.closeSearchView()
    }
}

protocol MeterialSearchDelegate: class {
    func selectMeterial(name: String)
    func closeSearchView()
}
