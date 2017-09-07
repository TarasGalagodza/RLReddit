//
//  TopPostTableViewFooter.swift
//  RLReddit
//
//  Created by Taras Galagodza on 9/7/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class TopPostTableViewFooter: UITableViewHeaderFooterView {

    var isLoadingInProgress: Bool = false {
        didSet {
            acitivityIndicator.isHidden = isLoadingInProgress
            if (isHidden == false) {
                acitivityIndicator.startAnimating()
            }
        }
    }

    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!

}
