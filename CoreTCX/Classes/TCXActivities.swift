//
//  TCXActivities.swift
//  CoreTCX
//
//  Created by Vincent on 30/8/19.
//

import Foundation

class TCXActivityList: TCXElement {
    var activity = [TCXActivity]()
}

public final class TCXActivity: TCXElement {
    public var sport: TCXSport
    var Id: Date?
    var lap: TCXActivityLap?
    var notes: String?
    
    public init(sportType: TCXSport) {
        self.sport = sportType
    }
    
}

public enum TCXSport: String {
    case running, biking, other
}

class TCXActivityLap: TCXElement {
    var startTime = Date()
    var totalTimeSeconds: Double?
    var distance: Double?
    var maxSpeed: Double?
    var calories: UInt16?
    var avgHeartRate: TCXHeartRateInBeatsPerMinute?
    var maxHeartRate: TCXHeartRateInBeatsPerMinute?
    var intensity: TCXIntensity?
    var cadence: TCXCadenceValue?
    var triggerMethod: TCXTriggerMethod?
    var track = [TCXTrack]()
    var notes: String?
    var extensions: TCXExtensions?
}

class TCXTrack: TCXElement {
    var trackpoint = [TCXTrackPoint]()
}

class TCXTrackPoint: TCXElement {
    var time: Date?
    var altitude: Double?
    var distance: Double?
    var heartRate: TCXHeartRateInBeatsPerMinute?
    var cadence: TCXCadenceValue?
    var sensorState: TCXSensorState?
}

typealias TCXHeartRateInBeatsPerMinute = UInt8

enum TCXIntensity {
    case active, resting
}
typealias TCXCadenceValue = UInt8

enum TCXTriggerMethod {
    case manual, distance, location, time, heartRate
}

class TCXPosition: TCXElement {
    var latitude: Double?
    var longitude: Double?
}

enum TCXSensorState {
    case present, absent
}
