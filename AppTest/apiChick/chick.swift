//
//  chick.swift
//  NewAppWork
//
//  Created by fathy  on 10/8/19.
//  Copyright © 2019 fathy . All rights reserved.
//

import Foundation
import Alamofire

class chick {
    static let inst = chick()
    func checkUserName(url:String, completion:@escaping (ModelsUser?,Error?)->()) {
       
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respons) in

            guard let data = respons.data else {return}
            switch respons.result{
            case.success(let value):
                print(value, "Value")
                do {
                    let dataCheck = try JSONDecoder().decode(ModelsUser.self, from: data)
                    completion(dataCheck,nil)
                }catch let error {
                    print(error)
                }
            case.failure(let error):
                completion(nil,error)
            }
        }
    
    }
}
