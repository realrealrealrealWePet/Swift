//
//  WalkViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit

class WalkViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    
    @IBOutlet var KakaoMapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: self.KakaoMapView.frame)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func SeeProfile(_ sender: Any) {
        guard let svc1 = self.storyboard?.instantiateViewController(identifier: "SeeProfileVC") as? SeeProfileViewController else {
            return
        }
        svc1.modalPresentationStyle = .overFullScreen
        self.present(svc1, animated: false)
    }
}
