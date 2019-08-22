//
//  GradientView.swift
//  Parks Picker
//
//  Created by Vasilii on 20/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class GradientView: UIView {

    // создаем градиентный слой
    lazy fileprivate var gradientLayer: CAGradientLayer  = {
        let color1 = UIColor.clear.cgColor
        let color2 = UIColor(white: 0.0, alpha: 0.75)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        return gradientLayer
    }()

    // начальные настройки view
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        layer.addSublayer(gradientLayer)
    }
    //когда происходит пересчет геометрии экрана
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds //внутренная рамка view
    }
}
