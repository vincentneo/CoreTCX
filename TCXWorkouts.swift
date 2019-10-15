//
//  TCXWorkouts.swift
//  CoreTCX
//
//  Created by Vincent Neo on 15/10/19.
//

import Foundation

class TCXWorkouts: TCXElement {
    
    var workout: [TCXWorkout]?
    
}

class TCXWorkout: TCXElement {
    var sport: String?
    var name: TCXRestrictedToken?
    //var step = abstractStep
    var scheduledOn: [Date]?
    var notes: String?
    //var creator: abstractsource
    var extensions: TCXExtensions?
    
}
