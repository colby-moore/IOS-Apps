//
//  ViewController.swift
//  maps_demo
//
//  Created by Colby Moore on 7/6/17.
//  Copyright © 2017 Colby Moore. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var mapView: GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        GMSServices.provideAPIKey("AIzaSyCP4d-T4TvglZBFS1_zzf1-kbiarmnIbhg")
        
        let camera = GMSCameraPosition.camera(withLatitude: 41.880333, longitude: -72.799755, zoom: 16)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(41.880333, -72.799755)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Starbucks Simsbury"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ViewController.next as (ViewController) -> () -> ()))
    }
    
    func next() {
        let nextLocation = CLLocationCoordinate2DMake(41.873990, -72.801104)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 17)
        
        let marker = GMSMarker(position: nextLocation)
        marker.title = "Mcladdens Simsbury"
        marker.snippet = "bar"
        marker.map = mapView
    }

}

