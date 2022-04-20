//
//  TCXWeek.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

public struct TCXWeek: TCXElement {
    var startDay: Date
    var notes: String?
    var extensions: TCXExtensions?
    
    public init() {
         startDay = Date()
    }
    
    public init(startDay: Date) {
         self.startDay = startDay
    }
    
    func tagName() -> String {
        return "Week"
    }
    
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        let dayAttr = TCXAttribute(name: "StartDay", value: DateConvert.toString(with: .day, from: startDay)!)
        tcx.appendOpenTag(indentation: indent(level: level), tag: tagName(), attributes: [dayAttr])
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: notes, tcx: &tcx, tagName: "Notes", indentationLevel: indentationLevel)
    }
    

}
