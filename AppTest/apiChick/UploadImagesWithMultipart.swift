//
//  UploadImagesWithMultipart.swift
//  Circle
//
//  Created by Hassan on 28/09/2019.
//  Copyright © 2019 Minds. All rights reserved.
//

import UIKit
import Alamofire

class UploadImagesWithMultipart {
    //var loader: LoadingView!
    let headers = ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjljZTAyMWQzM2Y5MTg5MGZkYjA2ZjliY2Y1YmMyMmY0ZTViMTVhOWM0ZGQwNjE2ODNhYTI4MmI3ZjM0ZGNmODgyNzM3ODUxNjI4ODhhOWQyIn0.eyJhdWQiOiIxIiwianRpIjoiOWNlMDIxZDMzZjkxODkwZmRiMDZmOWJjZjViYzIyZjRlNWIxNWE5YzRkZDA2MTY4M2FhMjgyYjdmMzRkY2Y4ODI3Mzc4NTE2Mjg4OGE5ZDIiLCJpYXQiOjE1NzM0MDkxMTAsIm5iZiI6MTU3MzQwOTExMCwiZXhwIjoxNjA1MDMxNTEwLCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.l-DAzbspkgHetm4OoSpiE_ppZkIcJamz00LGrkUacDpEPRjxsgZqkeL2jUqfih1ExM7hxBGlLh1ZfblnHUbvnKTc7AEaEhMIRxF9W_9gbn3mEgBNlsRnKsipHlS-OKrxSUC6XOaX8g7ghshRlCD0JedTRqfpyfGenxWdGeKpf6ohvxa75ekKDY-O0eopUtkyrx1HOxja6uwt9yGcq4ouHTo48NweI0_DsFUA6C2fnbDEhnNu8Lo5Gbc7hDQTqfD55taJr1UpBn3_1DDIs_VeG5rmFLiAx-gvrNfRF7zZlhV2lvENFPhE6zLWNKRFKHQPM-NAQbWNGXMBDcVollUQQtRXP3ejwW4Jl3JHBVPTo4Kn8pWxzAZbyVXral88fnakcmAzkVAv60Pe29B-HLF4txcMvej5KO8s68nbo7SSuIXbWa5td6IHk6sPX47qL_UjPm_Id8syhYHYcyCElIOUmv7fqd_l17pkt5JRzMZ0vUHToQSja5epAJpKZmkiLfKuD3zup6bB3QTVXVmhWmU5HYbS4ap1YHe8LTw0GALB1hiMeALr3rChXuyqFiTcBM_oWopf_opsO1r9ohgod92N3olQfaEeyc-8vHIhggGMl4Ji8IQMcqrKQXSn9dS1GY5rLMh_cs979qruhp3R96ALO57sCeYY15BhSqgxttDZMMw"]
    static let instance = UploadImagesWithMultipart()
    
    func requestWith(withName name: String, endUrl: String, viewController: UIViewController,imagesData: [Data]?, profile_image: Data? ,parameters: [String : Any]?, onCompletion: @escaping(Bool?, Error?)-> Void){
//        DispatchQueue.main.async {
//            self.loader = LoadingView.createLoaderView(owner: viewController)
//            self.loader.animateLoader(animationName: Animations.loadingFlip)
//        }
        //let headers: HTTPHeaders = SharedHandler.getHeaders()
        //print(headers)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = profile_image  {
                multipartFormData.append(data, withName: name, fileName: "image.png", mimeType: "image/png")
                print(data, "image_data" , "SINGLE_IMAGE")
            } else if let data = imagesData  {
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "image[\(i)]", fileName: "image.png", mimeType: "image/png")
                }
                print("multi_images")
            }
            for (key, value) in parameters ?? [:] {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.response?.statusCode {
                    case 200:
//                        DispatchQueue.main.async {
//                            print("Upload image successfully")
//                            self.loader.removeFromSuperview()
//                            self.loader.stopAnimation()
//                        }
                        print("SUCCESS_UPLOAD_IMAGE")
                        print(response.result.value, "VALUE")
                        onCompletion(true, nil)
                    case 422:
//                        DispatchQueue.main.async {
//                            print("Error in Uploading images(422)")
//                            self.loader.removeFromSuperview()
//                            self.loader.stopAnimation()
//                        }
                        print(response.result.value, "VALUE")
                        onCompletion(false, nil)
                    default:
//                        DispatchQueue.main.async {
//                            print("Error in Uploading images()")
//                            self.loader.removeFromSuperview()
//                            self.loader.stopAnimation()
//                        }
                        onCompletion(false, nil)
                    }
                })
                
            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.loader.removeFromSuperview()
//                    self.loader.stopAnimation()
//                }
                print("Error in upload: \(error.localizedDescription)")
                onCompletion(nil, error)
            }
        }
    }
}
