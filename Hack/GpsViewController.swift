//
//  GpsViewController.swift
//  Hack
//
//  Created by Douglas Queiroz on 6/21/16.
//  Copyright © 2016 Douglas Queiroz. All rights reserved.
//

import UIKit
import MapKit

class GpsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        
        self.mapView.region = region
        self.mapView.addAnnotation(annotation)
    }
}
