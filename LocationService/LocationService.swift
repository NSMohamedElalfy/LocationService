//
//  LocationService.swift
//  Weer
//
//  Created by Mohamed El-Alfy on 9/12/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import CoreLocation

 class LocationService: NSObject , CLLocationManagerDelegate  {
   
    
    private var didUpdateLocationCompletionHandler : ((location:CLLocation? , error:NSError?) -> ())?

   
    override init() {
        super.init()
    }
    
    
     func startUpdatingLocationWithCompletionHandler(locationManager:CLLocationManager , completionHandler : ((location:CLLocation? , error:NSError?) -> ())?){
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.didUpdateLocationCompletionHandler = completionHandler
    }
    
     func reverseGeoCodeLocation(geoCoder:CLGeocoder,location:CLLocation, completionHandler:((placemark:CLPlacemark?,error:NSError?) -> ())?){
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks:[AnyObject]!, error:NSError!) -> Void in
            if error != nil {
                completionHandler?(placemark:nil,error:error)
            }else{
                if let placemark = placemarks.first as? CLPlacemark {
                    completionHandler?(placemark:placemark,error:nil)
                }
            }
        })
    }

     func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == CLAuthorizationStatus.AuthorizedWhenInUse{
            manager.startUpdatingLocation()
        }
    }
    
     func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            self.didUpdateLocationCompletionHandler?(location: location,error: nil)
            manager.stopUpdatingLocation()
        }
    }
    
     func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        if error != nil {
          self.didUpdateLocationCompletionHandler?(location: nil,error: error)
        }
    }
    
    
    
    
}
