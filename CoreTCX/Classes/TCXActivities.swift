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
    
    override func tagName() -> String {
        return "Activity"
    }
    
}

public enum TCXSport: String {
    case running = "Running"
    case biking = "Biking"
    case other = "Other"
}

public final class TCXActivityLap: TCXElement {
    public var startTime: Date
    
    public var totalTimeSeconds: Double?
    public var distance: Double?
    public var maxSpeed: Double?
    public var calories: UInt16?
    public var avgHeartRate: TCXHeartRate?
    public var maxHeartRate: TCXHeartRate?
    public var intensity: TCXIntensity?
    public var cadence: UInt8?
    public var triggerMethod: TCXTriggerMethod?
    public var track = [TCXTrack]()
    public var notes: String?
    public var extensions: TCXExtensions?
    
    private func autoTagChild() {
        self.avgHeartRate?.type = .avg
        self.maxHeartRate?.type = .max
    }
    override func tagName() -> String {
        return "Lap"
    }
    
    public override init() {
        self.startTime = Date()
    }
    
    public init(startTime: Date) {
        self.startTime = startTime
    }
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        //let date = TCXAttribute(name: "StartTime", value: startTime)
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        
        autoTagChild()
        
        if let tTS = totalTimeSeconds {
            addProperty(forValue: tTS, tcx: &tcx, tagName: "TotalTimeSeconds", indentationLevel:
                indentationLevel)
        }
        
        if let dist = distance {
            addProperty(forValue: dist, tcx: &tcx, tagName: "DistanceMeters", indentationLevel: indentationLevel)
        }
        
        if let max = maxSpeed {
            addProperty(forValue: max, tcx: &tcx, tagName: "MaximumSpeed", indentationLevel: indentationLevel)
        }
        
        if let calories = calories {
            let intCal = Int(calories)
            
            addProperty(forValue: intCal, tcx: &tcx, tagName: "Calories", indentationLevel: indentationLevel)
        }
        
        self.avgHeartRate?.tcxTagging(&tcx, indentationLevel: indentationLevel)
        self.maxHeartRate?.tcxTagging(&tcx, indentationLevel: indentationLevel)
        
        
    }
}

public final class TCXTrack: TCXElement {
    var trackpoint = [TCXTrackPoint]()
}

class TCXTrackPoint: TCXElement {
    var time: Date?
    var altitude: Double?
    var distance: Double?
    var heartRate: TCXHeartRate?
    var cadence: UInt8?
    var sensorState: TCXSensorState?
}

public enum TCXHeartRateType: String {
    case avg = "AverageHeartRateBpm"
    case max = "MaximumHeartRateBpm", undefined
}

public class TCXHeartRate: TCXElement {
    var type = TCXHeartRateType.undefined
    
    public var value: UInt8
    
    public init(inBPM value: UInt8) {
        self.value = value
    }
    
    override func tagName() -> String {
        return type.rawValue
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        let strVal = String(value)
        addProperty(forValue: strVal, tcx: &tcx, tagName: "Value", indentationLevel: indentationLevel)
    }
}

public enum TCXIntensity: String {
    case active = "Active"
    case resting = "Resting"
}

public enum TCXTriggerMethod {
    case manual, distance, location, time, heartRate
}

class TCXPosition: TCXElement {
    var latitude: Double?
    var longitude: Double?
}

enum TCXSensorState {
    case present, absent
}
