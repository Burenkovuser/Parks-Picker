//
//  SectionHeaderView.swift
//  Parks Picker
//
//  Created by Vasilii on 22/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var title: String? {
        didSet {
            titleLabel.text = title
            iconImageView.image = UIImage(named: title!)
        }
    }
}
