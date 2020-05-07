//
//  TCXWorkouts.swift
//  CoreTCX
//
//  Created by Vincent Neo on 15/10/19.
//

import Foundation

/*
public final class TCXWorkouts: NSObject, TCXElement {
    
    var workout: [TCXWorkout]?
    
    public init(workouts: [TCXWorkout]) {
        self.workout = workouts
    }

}
*/

// WorkoutList_t
extension Array: TCXPublicElement where Element : TCXWorkout {}
extension Array: TCXElement where Element : TCXWorkout {
    func tagName() -> String {
        return "Workouts"
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        forEach { element in
            element.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
}

// Workout_t
public class TCXWorkout: NSObject, TCXElement {
    
    enum sportType: String {
        case running = "Running", biking = "Biking", other = "Other", undefined
    }
    func tagName() -> String {
        return "Workout"
    }
    
    var sport: sportType
    var name: String?
    var step = [TCXAbstractStep]() // at least one
    var scheduledOn: [Date]?
    var notes: String?
    //var creator: abstractsource
    var extensions: TCXExtensions?
    
    init(sport: sportType) {
        self.sport = sport
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: 330, tcx: &tcx, tagName: "Test", indentationLevel: indentationLevel)
    }
    
}

protocol TCXAbstract {
    
}

enum abs: TCXAbstract {
}

class TCXAbstractStep<type: abs>: TCXElement {
    func tagName() -> String {
        fatalError()
    }
    
    private var privateID = Int()
    
    public var stepID: Int {
        get {
            return privateID
        }
        set {
            if newValue > 0 && newValue <= 20 {
                privateID = newValue
            }
        }
    }
    
    
}
