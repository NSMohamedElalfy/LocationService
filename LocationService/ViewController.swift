//
//  ViewController.swift
//  LocationService
//
//  Created by Mohamed El-Alfy on 9/12/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    let locationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getCurrentLocation()
    }
    
    func getCurrentLocation(){
        self.locationService.startUpdatingLocationWithCompletionHandler(locationManager, completionHandler: { (location:CLLocation?, error:NSError?) -> () in
            
            // self.locationManager.stopUpdatingLocation()
            
            if let _error = error {
                println(_error.localizedDescription)
            }else{
                if let _location = location {
                    self.locationService.reverseGeoCodeLocation(self.geoCoder, location: _location, completionHandler: { (placemark:CLPlacemark?, error:NSError?) -> () in
                        if let _placemark = placemark{
                            self.addressLabel.text = "\(_placemark.name),\n\(_placemark.locality),\n\(_placemark.administrativeArea),\n\(_placemark.country).\nLatitude : \(_placemark.location.coordinate.latitude),\nLongitude : \(_placemark.location.coordinate.longitude)."
                        }
                    })
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

