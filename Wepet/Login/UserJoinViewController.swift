//
//  UserJoinViewController.swift
//  Wepet
//
//  Created by jaegu park on 30/09/23.
//

import UIKit

class UserJoinViewController: UIViewController {
    
    @IBOutlet var ProfileImage: UIImageView!
    @IBOutlet var NicknameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var CodeTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    @IBOutlet var BDTextField: UITextField!
    @IBOutlet var EmailView: UIStackView!
    @IBOutlet var CodeView: UIStackView!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CodeView.isHidden = true
        
        enrollAlertEvent()
        self.imagePickerController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func enrollAlertEvent() {
        let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) {
            (action) in
            self.openAlbum() // 아래에서 설명 예정.
        }
        
        let cameraAlertAction = UIAlertAction(title: "사진 촬영", style: .default) {
            (action) in
            self.openCamera() // 아래에서 설명 예정.
        }
    }
    
    @IBAction func PetJoinButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PetJoinVC") as? PetJoinViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SendButton(_ sender: Any) {
        CodeView.isHidden = false
    }
    
    @IBAction func Camera_Tapped(_ sender: Any) {
        self.openAlbum()
    }
}

extension UserJoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ProfileImage.image = image
        } else {
            print("error detected in didFinishPickinMEdiaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: false, completion: nil)
        } else {
            print("Camera is not available as for now")
        }
    }
}
