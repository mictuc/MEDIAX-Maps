//
//  ViewController.swift
//  Driving Data Recorder
//
//  Created by Michael Tucker on 1/19/16.
//  Copyright © 2016 DesignX. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    /// Map for the main view controller
    @IBOutlet weak var mapView: MKMapView!
    
    /// Monitoring drive
    var monitor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "recordDrive")
        
        toolbarItems?.insert(MKUserTrackingBarButtonItem(mapView: mapView), atIndex: 0)
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        segmentedControl.addTarget(self, action: "mapType:", forControlEvents: .ValueChanged)
        segmentedControl.selectedSegmentIndex = 0
        toolbarItems?.insert(UIBarButtonItem(customView: segmentedControl as UIView), atIndex: 2)

    }
    
    @IBAction func mapType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    /**
     Controls the start and stop of drive monitoring
     */
    func recordDrive() {
        monitor = !monitor
        
        /// If monitor is started, motion monitoring starts. When stopped, motion monitoring stops
        if monitor {
            sharedLocation.startMonitoringDeviceMotion()
            navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: "monitorDeviceMotion"), animated: true)
        } else {
            sharedLocation.stopMonitoringDeviceMotion()
            navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "monitorDeviceMotion"), animated: true)
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

