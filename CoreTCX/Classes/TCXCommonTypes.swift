//
//  TCXCommonTypes.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

open class TCXExtensions: TCXElement {
    func tagName() -> String {
        fatalError()
    }
}

public enum TCXTokenType: String {
    case workouts = "WorkoutNameRef"
    case courses = "CourseNameRef"
    case undefined
}

public class TCXRestrictedToken: TCXElement {
    
    public var id: String
    
    internal var type: TCXTokenType = .undefined
    
    func tagName() -> String {
        return type.rawValue // maybe shared. implement enum for all shared types
    }
    
    public init(id: String) {
        self.id = id
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: id, tcx: &tcx, tagName: "Id", indentationLevel: indentationLevel)
    }
}

