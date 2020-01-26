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

extension Array: TCXPublicElement where Element : TCXWorkout {
    public func tagName() -> String {
        return "Workouts"
    }
}

extension Array: TCXElement where Element : TCXWorkout {
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        forEach { element in
            element.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
}

public class TCXWorkout: NSObject, TCXElement {
    public func tagName() -> String {
        return "Workout"
    }
    
    var sport: String?
    var name: TCXRestrictedToken?
    var step = [TCXAbstractStep]()
    var scheduledOn: [Date]?
    var notes: String?
    //var creator: abstractsource
    var extensions: TCXExtensions?
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: 330, tcx: &tcx, tagName: "Test", indentationLevel: indentationLevel)
    }
    
}

class TCXAbstractStep: TCXElement {
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
