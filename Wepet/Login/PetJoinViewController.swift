//
//  PetJoinViewController.swift
//  Wepet
//
//  Created by jaegu park on 30/09/23.
//

import UIKit

class PetJoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func JoinFinishButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserJoinVC") as? UserJoinViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}
