//
//  Park.swift
//  Parks Picker
//
//  Created by Vasilii on 20/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import Foundation

class Park {
    
    var name: String
    var country: String
    var date: String
    var photo: String
    var index: Int
    
    init(name: String, country: String, date: String, photo: String, index: Int) {
        self.name = name
        self.country = country
        self.date = date
        self.photo = photo
        self.index = index
    }
    
    convenience init(copying park: Park) {
        self.init(name: park.name, country: park.country, date: park.date, photo: park.photo, index: park.index)
    }
}
