//
//  cornar.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/21/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import UIKit

class cornar: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        clipsToBounds = true
        
        
    }
   

}
