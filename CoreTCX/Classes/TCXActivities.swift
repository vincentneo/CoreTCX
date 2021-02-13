//
//  TCXActivities.swift
//  CoreTCX
//
//  Created by Vincent on 30/8/19.
//

import Foundation

class TCXActivities: TCXElement {
    
    var activity = [TCXActivity]()
    var multiSportSession = [TCXMultiSportSession]()
    
    func tagName() -> String {
        return "Activities"
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        for eachActivity in activity {
            eachActivity.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        for each in multiSportSession {
            each.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
}
public final class TCXMultiSportSession: TCXElement {
    func tagName() -> String {
        return "MultiSportSession"
    }
    
    public var id: Date?
    public var firstSport: TCXActivity?
    public var nextSport = [NextSport]() // implement nextSport element
    
    public class NextSport {
        public var transition: TCXActivityLap?
        public var activity: TCXActivity
        
        public init(activity: TCXActivity, transition: TCXActivityLap) {
            self.transition = transition
            self.activity = activity
        }
    }
    
    public init() {
        
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        if let id = id {
            addProperty(forValue: DateConvert.toString(with: .ISO8601UTC, from: id), tcx: &tcx, tagName: "Id", indentationLevel: indentationLevel)
        }
        if let fS = firstSport {
            tcx.append(String(format: "%@<%@>\r\n", indent(level: indentationLevel), "FirstSport"))
            fS.tcxTagging(&tcx, indentationLevel: indentationLevel + 1)
            tcx.append(String(format: "%@</%@>\r\n", indent(level: indentationLevel), "FirstSport"))
        }
        
    }
}

public final class TCXActivity: TCXElement {
    public var sport: TCXSport
    public var Id: Date?
    public var lap: TCXActivityLap?
    public var notes: String?
    
    public init(sportType: TCXSport) {
        self.sport = sportType
    }
    
    func tagName() -> String {
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
    func tagName() -> String {
        return "Lap"
    }
    
    public init() {
        self.startTime = Date()
    }
    
    public init(startTime: Date) {
        self.startTime = startTime
    }
    
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        //let date = TCXAttribute(name: "StartTime", value: DateConvert.toString(with: .day, from: startTime))
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        
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
    func tagName() -> String {
        fatalError()
    }
    
    var trackpoint = [TCXTrackPoint]()
}

class TCXTrackPoint: TCXElement {
    func tagName() -> String {
        fatalError()
    }
    
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
    
    func tagName() -> String {
        return type.rawValue
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
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
    func tagName() -> String {
        fatalError()
    }
    
    var latitude: Double?
    var longitude: Double?
}

enum TCXSensorState {
    case present, absent
}
