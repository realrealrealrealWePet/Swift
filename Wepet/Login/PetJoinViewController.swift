//
//  PetJoinViewController.swift
//  Wepet
//
//  Created by jaegu park on 30/09/23.
//

import UIKit
import DropDown

class PetJoinViewController: UIViewController {
    
    @IBOutlet var ProfileImage: UIImageView!
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var KindTextField: UITextField!
    @IBOutlet var AgeTextField: UITextField!
    @IBOutlet var GenderTextField: UITextField!
    @IBOutlet var NeuterTextField: UITextField!
    @IBOutlet var JoinButton: UIButton!
    
    let dropGender = DropDown()
    let dropNeuter = DropDown()
    let Gender = [" 남자", " 여자"]
    let Neuter = [" 했음", " 안했음"]
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.height / 2
        ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
        
        textFieldDidBeginEditing(NameTextField)
        textFieldDidBeginEditing(KindTextField)
        textFieldDidBeginEditing(AgeTextField)
        textFieldDidEndEditing(NameTextField)
        textFieldDidEndEditing(KindTextField)
        textFieldDidEndEditing(AgeTextField)
        
        GenderTextField.isEnabled = false
        NeuterTextField.isEnabled = false
        JoinButton.isEnabled = false
        
        enrollAlertEvent()
        self.imagePickerController.delegate = self
        
        initUIGender()
        setDropGender()
        initUINeuter()
        setDropNeuter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
    }
    
    func initUIGender() {
        DropDown.appearance().textColor = UIColor.darkGray // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.black // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.white // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(5)
            dropGender.dismissMode = .automatic // 팝업을 닫을 모드 설정
        DropDown.appearance().textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    func initUINeuter() {
        DropDown.appearance().textColor = UIColor.darkGray // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.black // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.white // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(5)
            dropNeuter.dismissMode = .automatic // 팝업을 닫을 모드 설정
        DropDown.appearance().textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    func setDropGender() {
        // dataSource로 ItemList를 연결
        dropGender.dataSource = Gender
        dropGender.cellHeight = 35
        // anchorView를 통해 UI와 연결
        dropGender.anchorView = self.GenderTextField
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropGender.bottomOffset = CGPoint(x: 0, y: GenderTextField.bounds.height)
        
        // Item 선택 시 처리
        dropGender.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.GenderTextField.text = " \(item)"
            self!.GenderTextField.layer.borderColor = UIColor.clear.cgColor
            self!.GenderTextField.layer.cornerRadius = 5
            self!.GenderTextField.layer.borderWidth = 1.0
            if index == 0 {
                
            } else if index == 1 {
                
            }
        }
        
        // 취소 시 처리
        dropGender.cancelAction = { [weak self] in
        }
    }
    
    func setDropNeuter() {
        // dataSource로 ItemList를 연결
        dropNeuter.dataSource = Neuter
        dropNeuter.cellHeight = 35
        // anchorView를 통해 UI와 연결
        dropNeuter.anchorView = self.NeuterTextField
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropNeuter.bottomOffset = CGPoint(x: 0, y: NeuterTextField.bounds.height)
        
        // Item 선택 시 처리
        dropNeuter.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.NeuterTextField.text = " \(item)"
            self!.NeuterTextField.layer.borderColor = UIColor.clear.cgColor
            self!.NeuterTextField.layer.cornerRadius = 5
            self!.NeuterTextField.layer.borderWidth = 1.0
            if index == 0 {
                
            } else if index == 1 {
                
            }
        }
        
        // 취소 시 처리
        dropNeuter.cancelAction = { [weak self] in
        }
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
    
    @IBAction func JoinFinishButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserJoinVC") as? UserJoinViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @IBAction func Camera_Tapped(_ sender: Any) {
        self.openAlbum()
    }
    
    @IBAction func Gender_Tapped(_ sender: Any) {
        dropGender.show()
    }
    
    @IBAction func Neuter_Tapped(_ sender: Any) {
        dropNeuter.show()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PetJoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
