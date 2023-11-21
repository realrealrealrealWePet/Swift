//
//  WalkViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit

class WalkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func MapButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapViewController else { return }

        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}
