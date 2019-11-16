//
//  ViewController.swift
//  NewAppWork
//
//  Created by fathy  on 10/8/19.
//  Copyright © 2019 fathy . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var labAva: UILabel!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var textPass: UITextField!
    @IBOutlet weak var textRewritePass: UITextField!
    
    @IBOutlet weak var textPhon: UITextField!
    
    @IBOutlet weak var textCode: UITextField!
    
    @IBOutlet weak var buttonRsendOutlet: UIButton!
    
    @IBOutlet weak var buttonContinueOutlet: UIButton!
    
   var code = 0
   var timer: Timer!
    var counter: Int = 60 {
        didSet {
            buttonRsendOutlet.setTitle("Resend Code: \(counter)", for: .normal)
        }
    }
    fileprivate func alartMessage(Message: String) {
        let Allert = UIAlertController(title: "Error", message: Message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Delete", style: .default, handler: nil)
        Allert.addAction(ok)
        present(Allert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labAva.layer.cornerRadius = 5
        labAva.clipsToBounds = true
        userName.delegate = self
        
        buttonContinueOutlet.setTitle("Register", for: .normal)
        alartMessage(Message: "")
        buttonRsendOutlet.isEnabled = false
        self.spinner.isHidden = true
    }

    @IBAction func buttonContinueAction(_ sender: UIButton) {
        if buttonContinueOutlet.title(for: .normal) == "Register" {
           
            guard let userName = userName.text ,  !userName.isEmpty else {
                
                alartMessage(Message: "pless enter name")
                return
            }
            guard let pass = textPass.text , !pass.isEmpty else{
                alartMessage(Message: "pless enter password")
                return
            }
            guard let rewirtpass = textRewritePass.text , !rewirtpass.isEmpty else {
                alartMessage(Message: "plass enter password")
                return
            }
            if textPass.text != textRewritePass.text{
                alartMessage(Message: "plass enter password")
            }
            if textPass.text!.count  >= 8 {
                
            }else {
                alartMessage(Message: "plass enter password 8 namber")
                return
            }
            guard let phon = textPhon.text , !phon.isEmpty else{
                alartMessage(Message: "pless enter phon nambur")
                return
            }
            self.spinner.isHidden = false
            spinner.startAnimating()
            apiSugnUp.instel.SugnUp(url:BASE_URL + "signup", username: userName, password: pass, phon: phon, passwordConfirmation: rewirtpass) { (signUpData, signUpDataError,error) in
                if let myerror = error{
                    print(myerror)
                    self.spinner.stopAnimating()
                    self.alartMessage(Message: "error")
                }else if let signUpDataError = signUpDataError {
                    self.alartMessage(Message: signUpDataError.message ?? "")
                    
                } else {
                    guard let signUpData = signUpData else { return }
                    self.alartMessage(Message: signUpData.message ?? "")
                    self.code = signUpData.code ?? 0
                    self.buttonContinueOutlet.setTitle("Continue", for: .normal)
                    print(signUpData.code)
                    self.buttonRsendOutlet.isEnabled = true
                }
            }
        } else {
            guard let mycode = textCode.text , !mycode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                alartMessage(Message: "Please enter code")
                return }
            self.spinner.startAnimating()
            apiconfirmCode.instel.rsend(url: BASE_URL + "confirmUser", phon: textPhon.text ?? "", code: Int(mycode) ?? 0) { (confirmcode, singnup, error) in
                print(self.textCode.text, self.textPhon.text, "CHECK_CODE")
                if let myerror = error{
                    print(myerror)
                    self.spinner.stopAnimating()
                    self.alartMessage(Message: "error")
                }else if let signUpDataError = singnup {
                    self.alartMessage(Message: signUpDataError.message ?? "")
                    
                } else {
                    guard let confermCode = confirmcode else { return }
                print(confermCode.message)
                    self.spinner.startAnimating()
                    if  let uploadImagesVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadImagesViewController") as? UploadImagesViewController{
                    
                    self.present(uploadImagesVC, animated: true, completion: nil)
                        self.spinner.stopAnimating()
                    }
                
                }
            }
        }
    }
    @IBAction func resendButtonAction(_ sender: UIButton) {
        guard let phone = textPhon.text , !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alartMessage(Message: "Please enter phone number")
            return }
       
        buttonContinueOutlet.isEnabled = false
        self.spinner.startAnimating()
        apiResend.instel.rsend(url: BASE_URL + "resend_code", phon: textPhon.text ?? "") { (resendCode, error) in
            if let myerror = error{
                print(myerror)
                self.spinner.stopAnimating()
                self.alartMessage(Message: "error")
            }else{
                guard let resend = resendCode else {return}
                print(resendCode?.code)
                self.code = resend.code ?? 0
                sender.isEnabled = false
                self.setTimer()
            }
        }
    }
}
// MARK: - Helper Methods
extension ViewController {
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
    }
    @objc func countDownMethod() {
        if counter > 0 {
            counter -= 1
        } else {
            counter = 60
            timer.invalidate()
            buttonContinueOutlet.isEnabled = true
            buttonRsendOutlet.isEnabled = true
        }
    }
}
extension ViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userName {
            self.spinner.startAnimating()
            chick.inst.checkUserName(url:BASE_URL + "check_username?username=\(userName.text ?? "")") { (data,Error) in
                if  let myerror = Error {
                    print(myerror)
                    self.spinner.stopAnimating()
                } else {
                    guard let mydata = data else {return}
                    
                    if mydata.message == "valid username" {
                        self.labAva.isHidden = false
                    } else {
                        self.labAva.isHidden = false
                        self.labAva.text = "Unavailable"
                        self.labAva.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                    }
                }
            }
        }
    }
}
