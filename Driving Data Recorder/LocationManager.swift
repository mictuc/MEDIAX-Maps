//
//  LocationManager.swift
//  Driving Data Recorder
//
//  Created by Michael Tucker on 1/19/16.
//  Copyright © 2016 DesignX. All rights reserved.
//

import CoreLocation

/// Manages apps location data
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    /// Manager for the LocationManager class
    let manager = CLLocationManager()
    
    /// Array of CLLocations to be used by other classes
    var locations = [CLLocation]()
    
    ///Initializes self
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    /// Updates locations
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.locations.append(location)
        }
    }
    
    /**
     Begins monitoring device motion and creates new Drive object
     */
    func startMonitoringDeviceMotion() {
        sharedLocation.manager.startUpdatingLocation()
        drive = NSEntityDescription.insertNewObjectForEntityForName("Drive", inManagedObjectContext: managedObjectContext) as! Drive
        startMonitoringDate = NSDate()
    }
    
    /**
     Stops monitoring device and stores data in Drive Object
     */
    func stopMonitoringDeviceMotion() {
        sharedLocation.manager.stopUpdatingLocation()
        storeDeviceMotionData()
        appDelegate.saveContext()
    }

}

/// LocationManager object to be used in other classes
let sharedLocation = LocationManager()