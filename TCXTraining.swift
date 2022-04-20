//
//  TCXTraining.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

public struct TCXTraining: TCXElement {
    func tagName() -> String {
        return "Training"
    }
    
    public var quickWorkoutResults: TCXQuickWorkout?
}
