//
//  MeasuringToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class MeasuringToolViewController: UIViewController {
    var dimScreen: UIView!

    @IBOutlet weak var menuTitle: UILabel!

    @IBOutlet weak var toolTableView: UITableView!
    @IBOutlet weak var basicMeasuringToolButton: UIButton!
    @IBOutlet weak var livingMeasuringToolButton: UIButton!
    @IBOutlet weak var tabIndicatorView: UIView!

    @IBOutlet weak var editMeasuringToolButton: UIButton!
    var closeEditButton: UIButton!
    var deleteEditButton: UIButton!

    var measuringToolManager: RealmMeasuringToolManager?
    var measuringToolList: [MeasuringTool]?
    var selectedToolList: [MeasuringTool]?

    var isBasicToolSelected = true {
        didSet {
            self.toolTableView.reloadData()
        }
    }
    var isToolEdited = false {
        didSet {
            self.toolTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self

        self.selectedToolList = []

        setupMeasuringToolTabBar()
        setupEditButtons()
        setupDimScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        if isBasicToolSelected {
            self.measuringToolList = measuringToolManager?.getBasicMeasuringToolList()
        } else {
            self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()
        }

        hideEditButtons()
        self.toolTableView.reloadData()
    }
}
