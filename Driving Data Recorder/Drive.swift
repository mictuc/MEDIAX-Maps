//
//  Drive.swift
//  Driving Data Recorder
//
//  Drive core data object
//
//  Michael P Tucker on 1/25/16
//  Copyright (c) 2016 Stanford University. All rights reserved.
//

import CoreData

/// An recorded driving event with turns
class Drive: NSManagedObject {
    
    /// The stored locations of the drive as an [CLLocation]
    @NSManaged var locations: AnyObject
    
    /// Time the drive started
    @NSManaged var timestamp: NSDate
    
    /// Video of the drive
    @NSManaged var screenCast: AnyObject
    
    /// Picture of map
    @NSManaged var map: AnyObject
}
