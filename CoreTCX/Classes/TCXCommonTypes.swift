//
//  TCXCommonTypes.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public final class TCXWeek: TCXElement {
    var startDay: Date
    var notes: String?
    var extensions: TCXExtensions?
    
    public override init() {
         startDay = Date()
    }
    
    public init(startDay: Date) {
         self.startDay = startDay
    }
    
    override func tagName() -> String {
        return "Week"
    }
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        let dayAttr = TCXAttribute(name: "StartDay", value: DateConvert.toString(with: .day, from: startDay)!)
        tcx.appendOpenTag(indentation: indent(level: level), tag: tagName(), attributes: [dayAttr])
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: notes, tcx: &tcx, tagName: "Notes", indentationLevel: indentationLevel)
    }
    

}

open class TCXExtensions: TCXElement {
    
}

public enum TCXTokenType: String {
    case workouts = "WorkoutNameRef"
    case courses = "CourseNameRef"
    case undefined
}

public class TCXRestrictedToken: TCXElement {
    
    public var id: String
    
    internal var type: TCXTokenType = .undefined
    
    override func tagName() -> String {
        return type.rawValue // maybe shared. implement enum for all shared types
    }
    
    public init(id: String) {
        self.id = id
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: id, tcx: &tcx, tagName: "Id", indentationLevel: indentationLevel)
    }
}

