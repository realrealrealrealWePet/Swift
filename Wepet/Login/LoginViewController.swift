//
//  LoginViewController.swift
//  Wepet
//
//  Created by jaegu park on 30/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    @IBOutlet var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        LoginButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func JoinButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserJoinVC") as? UserJoinViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        guard let rvc = stb.instantiateViewController(withIdentifier: "MainTabViewController") as? MainTabViewController else {return}
        
        self.navigationController?.pushViewController(rvc, animated: false)
    }
}
