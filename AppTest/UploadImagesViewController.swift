//
//  UploadImagesViewController.swift
//  AppTest
//
//  Created by Ahmed Mostafa on 10/23/19.
//  Copyright © 2019 Ahmed Mostafa. All rights reserved.
//

import UIKit

class UploadImagesViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    var selectedImage: UIImage? {
        didSet {
            profileImageView.image = selectedImage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(opengalary))
        profileImageView.addGestureRecognizer(tap)
    }
    @objc func opengalary() {
        let alert = UIAlertController(title: "Choose", message: "Choose image source", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            let imagepicker = UIImagePickerController()
            imagepicker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagepicker, animated: true, completion: nil)
            }
            // Has camera
            self.present(imagepicker, animated: true, completion: nil)
        }
        let galary = UIAlertAction(title: "Galary", style: .default) { (action) in
            let imagepicker = UIImagePickerController()
            imagepicker.delegate = self
            imagepicker.sourceType = .photoLibrary
            self.present(imagepicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(galary)
         alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func BackButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let image = selectedImage else {
            createAlert(title: "Warinig", message: "Please choose image")
            return
        }
        var imagesData = [Data]()
        if let imageData = selectedImage?.jpegData(compressionQuality: 0.01) {
            imagesData.append(imageData)
        }
        UploadImagesWithMultipart.instance.requestWith(withName: "", endUrl: BASE_URL + "profileImages", viewController: self, imagesData: imagesData, profile_image: nil, parameters: nil) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let succes = success else { return }
                if let updateProfileImageVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") as? UpdateProfileViewController {
                    self.present(updateProfileImageVC, animated: true, completion: nil)
                }
            }
        }
    }
    fileprivate func createAlert(title: String, message: String) {
        let Allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        Allert.addAction(ok)
        present(Allert, animated: true, completion: nil)
    }
}
extension UploadImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.selectedImage = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
