//
//  ApiConfermCode.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/23/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import Foundation
import Alamofire
class apiconfirmCode{
    static let instel = apiconfirmCode()
    func rsend(url: String,phon: String ,code: Int ,completion: @escaping (confirm_code? ,SignUpErrorModel?,Error?)->()){
        let parameters = ["phone":phon,"code":code] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters:parameters , encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else {return}
           
            switch response.result{
            case .success(let value):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200:
                    do{
                        let registerDate = try JSONDecoder().decode(confirm_code.self, from: data)
                        completion(registerDate,nil,nil)
                    }catch let jsonError{
                        print(jsonError)
                    }
                case 406:
                    do{
                        let codeError = try JSONDecoder().decode(SignUpErrorModel.self, from: data)
                        completion(nil,codeError,nil)
                    }catch let jsonError{
                        print(jsonError)
                    }
                case 422:
                    do{
                        let registerDateError = try JSONDecoder().decode(SignUpErrorModel.self, from: data)
                        completion(nil,registerDateError,nil)
                    }catch let jsonError{
                        print(jsonError)
                    }
                default:
                    break
                }
            case .failure(let myError):
                completion(nil,nil,myError)
            }
        }
        
    }
}
