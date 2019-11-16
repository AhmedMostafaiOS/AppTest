//
//  ooooViewController.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 11/12/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import UIKit

class ooooViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        image.layer.cornerRadius = 30
        image.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        image.layer.shadowRadius = 2
        image.layer.shadowOpacity = 5
        image.layer.shadowOffset = CGSize(width: 0, height: 5)
        
    }
 

}
