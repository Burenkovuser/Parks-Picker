//
//  DetailViewController.swift
//  Parks Picker
//
//  Created by Vasilii on 20/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var countryLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    
    var park: Park?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //перед отображением заполняем данными
        if let nationalPark = park {
            navigationItem.title = nationalPark.name
            imageView.image = UIImage(named: nationalPark.photo)
            nameLabel.text = nationalPark.name
            countryLabel.text = nationalPark.country
            dateLabel.text = nationalPark.date
        }
        
    }
}
