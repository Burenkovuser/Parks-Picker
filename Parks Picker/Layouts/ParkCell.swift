//
//  ParkCell.swift
//  Parks Picker
//
//  Created by Vasilii on 20/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class ParkCell: UICollectionViewCell {
    
    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var capitonLabel: UILabel!
    @IBOutlet weak var checkedImageView: UIImageView!
    
    var park: Park? {
        //наблюдатель, если удасться извлечь опционал, устанавливаем изображение
        didSet{
            if let nationalPark = park {
                parkImageView.image = UIImage(named: nationalPark.photo)
                capitonLabel.text = nationalPark.photo
            }
        }
    }
    
    var editing: Bool = false {
        didSet {
            capitonLabel.isHidden = editing // название прячится
            checkedImageView.isHidden = !editing // картинка кружка появляется
        }
    }
    // в зависимости от режима редактирования поазывает картинку
    override var isSelected: Bool {
        didSet {
            if editing {
                checkedImageView.image = UIImage(named: isSelected ? "Checked" : "Unchecked" )
            }
        }
    }
    
    //подготовка к повторному использованию
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        parkImageView.image = nil
        capitonLabel.text = ""
        
        if editing {
            checkedImageView.image = UIImage(named: isSelected ? "Checked" : "Unchecked" )
        }
    }
    
}
