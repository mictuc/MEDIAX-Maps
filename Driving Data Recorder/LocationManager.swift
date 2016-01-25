//
//  LocationManager.swift
//  Driving Data Recorder
//
//  Created by Michael Tucker on 1/19/16.
//  Copyright © 2016 DesignX. All rights reserved.
//

import CoreLocation
import CoreData
import CoreMotion
import UIKit


/// Manages apps location data
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    /// Manager for the LocationManager class
    let manager = CLLocationManager()
    
    /// Array of CLLocations to be used by other classes
    var locations = [CLLocation]()
    
    /// Manager for core data objects
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /// AppDelegate to manage data and processes for the app
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    /// Drive event
    lazy var drive = NSManagedObject() as! Drive
    
    /// Timestamp for beginning of drive
    var startMonitoringDate: NSDate!

    
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
     Stores the timestamp and locations data to the drive.
     */
    func storeDeviceMotionData(){
        drive.timestamp = startMonitoringDate
        drive.locations = sharedLocation.locations
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