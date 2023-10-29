//
//  Item.swift
//  gpslogger-swiftui
//
//  Created by 井上晴稀 on 2023/10/22.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class LocationItem {
    var latitude: Double
    var longitude: Double
    var altitude: Double
    var ellipsoidalAltitude: Double
    var horizontalAccuracy: Double
    var verticalAccuracy: Double
    var speed: Double
    var speedAccuracy: Double
    var course: Double
    var courseAccuracy: Double
    var timestamp: Date
    
    init(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        altitude: CLLocationDistance,
        ellipsoidalAltitude: CLLocationDistance,
        horizontalAccuracy: CLLocationAccuracy,
        verticalAccuracy: CLLocationAccuracy,
        speed: CLLocationSpeed,
        speedAccuracy: CLLocationSpeedAccuracy,
        course: CLLocationDirection,
        courseAccuracy: CLLocationDirectionAccuracy,
        timestamp: Date
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.ellipsoidalAltitude = ellipsoidalAltitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.speed = speed
        self.speedAccuracy = speedAccuracy
        self.course = course
        self.courseAccuracy = courseAccuracy
        self.timestamp = timestamp
    }
}
