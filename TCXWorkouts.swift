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
extension Array: TCXElement where Element : TCXWorkout {
    public func tagName() -> String {
        return "Workouts"
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        forEach { element in
            element.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
}

public class TCXWorkout: TCXElement {
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
    
}

class TCXAbstractStep: TCXElement {
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
