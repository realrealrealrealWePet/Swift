//
//  MyHomeViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit

class MyHomeViewController: UIViewController {

    @IBOutlet var MyHomeCV: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.MyHomeCV.delegate = self
        self.MyHomeCV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func Edit_Profile(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditUserVC") as? EditUserViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func Edit_Pet(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditPetVC") as? EditPetViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
