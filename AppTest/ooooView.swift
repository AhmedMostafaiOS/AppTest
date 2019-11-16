//
//  ooooView.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 11/12/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import UIKit

class ooooView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        //layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        //layer.borderWidth = 2
       // layer.cornerRadius = 40
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
    }
}
