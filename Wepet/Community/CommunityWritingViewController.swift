//
//  CommunityWritingViewController.swift
//  Wepet
//
//  Created by jaegu park on 13/11/23.
//

import UIKit
import DropDown

class CommunityWritingViewController: UIViewController {
    
    @IBOutlet var CategoryTextField: UITextField!
    @IBOutlet var ContentView: UIStackView!
    @IBOutlet var CautionView: UIStackView!
    
    
    let drop = DropDown()
    let Gender = [" 자유게시판", " 알바해주개", " 알바할개요"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryTextField.isEnabled = false
        
        CautionView.isHidden = true

        initUI()
        setDropdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func initUI() {
        DropDown.appearance().textColor = UIColor.darkGray // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.black // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.white // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(5)
        drop.dismissMode = .automatic // 팝업을 닫을 모드 설정
        DropDown.appearance().textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        drop.dataSource = Gender
        drop.cellHeight = 35
        // anchorView를 통해 UI와 연결
        drop.anchorView = self.CategoryTextField
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        drop.bottomOffset = CGPoint(x: 0, y: CategoryTextField.bounds.height)
        
        // Item 선택 시 처리
        drop.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.CategoryTextField.text = " \(item)"
            self!.CategoryTextField.layer.borderColor = UIColor.clear.cgColor
            self!.CategoryTextField.layer.cornerRadius = 5
            self!.CategoryTextField.layer.borderWidth = 1.0
            if index == 0 {
                self?.CautionView.isHidden = true
            } else if index == 1 {
                self?.CautionView.isHidden = false
            } else if index == 2 {
                self?.CautionView.isHidden = true
            }
        }
        
        // 취소 시 처리
        drop.cancelAction = { [weak self] in
        }
    }
    
    @IBAction func Category_Tapped(_ sender: Any) {
        drop.show()
    }
}
