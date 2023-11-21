//
//  MapViewController.swift
//  Wepet
//
//  Created by jaegu park on 21/11/23.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
        }
    }

}
