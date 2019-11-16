//
//  ResendApi.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/23/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import Foundation
import Alamofire
class apiResend{
static let instel = apiResend()
    func rsend(url: String,phon: String ,completion: @escaping (SignupSuccessModel? ,Error?)->()){
        let parameters = ["phone":phon]
    
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        guard let data = response.data else {return}
        switch response.result{
        case.success(let value):
            print(value, "Value")
            do {
                let dataResend = try JSONDecoder().decode(SignupSuccessModel.self, from: data)
                completion(dataResend,nil)
            }catch let error {
                print(error)
            }
        case.failure(let error):
            completion(nil,error)
        }
        }
        
    }
}
