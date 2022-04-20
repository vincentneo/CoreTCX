//
//  File.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

public struct TCXPlan {
    public var name: TCXRestrictedToken?
    public var extensions: TCXExtensions?
    public var trainingType: TCXTrainingType
    public var intervalWorkout: Bool
}
