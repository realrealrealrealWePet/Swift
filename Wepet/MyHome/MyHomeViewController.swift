//
//  MyHomeViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit
import DropDown

class MyHomeViewController: UIViewController {
    
    @IBOutlet var UserImage: UIImageView!
    @IBOutlet var PetImage: UIImageView!
    @IBOutlet var MyHomeCV: UICollectionView!
    @IBOutlet var MenuButton: UIButton!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    
    let dropDown = DropDown()
    
    let mypage = ["내 정보 수정", "펫 정보 수정"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        UserImage.layer.cornerRadius = self.UserImage.frame.size.height / 2
        UserImage.layer.masksToBounds = true
        UserImage.clipsToBounds = true
        PetImage.layer.cornerRadius = self.PetImage.frame.size.height / 2
        PetImage.layer.masksToBounds = true
        PetImage.clipsToBounds = true

        self.MyHomeCV.delegate = self
        self.MyHomeCV.dataSource = self
        
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
        DropDown.appearance().textColor = UIColor.white // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.black // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor(named: "MainColor1")!  // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor(red: 36/255, green: 117/255, blue: 53/255, alpha: 1) // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(15)
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        DropDown.appearance().textFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        dropDown.dataSource = mypage
        dropDown.cellHeight = 35
        // anchorView를 통해 UI와 연결
        dropDown.anchorView = self.MenuButton
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: MenuButton.bounds.height)
        
        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, item) in
            if index == 0 {
                guard let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "EditUserVC") as? EditUserViewController else { return }

                self?.navigationController?.pushViewController(nextVC, animated: true)
            } else if index == 1 {
                guard let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "EditPetVC") as? EditPetViewController else { return }

                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
        }
    }
    
    func UserInfoResult() {
        
        let url = APIURL.mypageURL + "/info"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(" ", forHTTPHeaderField: "X-ACCESS-TOKEN")
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(UserInfoModel.self, from: safeData)
                    DispatchQueue.main.async {
                        let url = URL(string: decodedData.imageUrl ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
                        self.UserImage.load(url: url!)
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }

    @IBAction func Menu_Tapped(_ sender: Any) {
        dropDown.show()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
