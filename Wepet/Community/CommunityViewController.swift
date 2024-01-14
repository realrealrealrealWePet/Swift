//
//  CommunityViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit

class CommunityViewController: UIViewController {
    
    @IBOutlet var CommunityView: UIView!
    @IBOutlet var AlbaHaeView: UIView!
    @IBOutlet var AlbaHalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommunityView.alpha = 1
        AlbaHaeView.alpha = 0
        AlbaHalView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func Community_Tapped(_ sender: Any) {
        CommunityView.alpha = 1
        AlbaHaeView.alpha = 0
        AlbaHalView.alpha = 0
    }
    
    @IBAction func AlbaHal_Tapped(_ sender: Any) {
        CommunityView.alpha = 0
        AlbaHalView.alpha = 1
        AlbaHaeView.alpha = 0
    }
    
    @IBAction func AlbaHae_Tapped(_ sender: Any) {
        CommunityView.alpha = 0
        AlbaHalView.alpha = 0
        AlbaHaeView.alpha = 1
    }
    
    @IBAction func Writing_Tapped(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CommunityWritingVC") as? CommunityWritingViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
