//
//  PageView.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class PageView: UIView {
    var pageTitle: UILabel!
    var pageDescription: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupPageTitle(_ text: String) {
        pageTitle = UILabel()

        pageTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        pageTitle.textColor = UIColor.amDarkBlueGrey
        pageTitle.textAlignment = .center

        pageTitle.text = text
    }

    func setupPageDescription(_ text: String) {
        pageDescription = UILabel()

        pageDescription.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pageDescription.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)
        pageDescription.textAlignment = .center
        pageDescription.numberOfLines = 0

        pageDescription.text = text
    }
}
