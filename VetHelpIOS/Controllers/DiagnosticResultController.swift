//
//  DiagnosticResultController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 09.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import UIKit
import GoogleMaps

class DiagnosticResultController: UIViewController {
    

    @IBOutlet weak var customView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude:  51.20, longitude: 39.30, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.customView = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.20, longitude: 39.30)
        marker.title = "Voronezh"
        marker.snippet = "Russia"
        marker.map = mapView
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
