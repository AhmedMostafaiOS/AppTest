//
//  cornar+colarButton.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/10/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import UIKit

class cornar_colarButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 5)
      layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
   layer.shadowRadius = 5
       layer.shadowOpacity = 1
    }
}
