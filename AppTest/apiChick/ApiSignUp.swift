//
//  ApiSignUp.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/10/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import Foundation
import Alamofire
class apiSugnUp{
    static let instel = apiSugnUp()
    func SugnUp(url: String,username: String,password: String,phon: String,passwordConfirmation:String,completion:@escaping (SignupSuccessModel? ,SignUpErrorModel? ,Error?)->()){
        let parameters = ["username":username,"phone":phon,"password":password,"password_confirmation":passwordConfirmation]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard   let date = response.data else{
                return
            }
            switch response.result{
            case .success(let value):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 201:
                    do{
                        let registerDate = try JSONDecoder().decode(SignupSuccessModel.self, from: date)
                        completion(registerDate,nil,nil)
                    }catch let jsonError{
                        print(jsonError)
                    }
                case 422:
                    do{
                        let registerDateError = try JSONDecoder().decode(SignUpErrorModel.self, from: date)
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


