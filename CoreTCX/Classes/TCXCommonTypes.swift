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
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel: Int) {
        let dayAttr = TCXAttribute(name: "StartDay", value: DateConvert.toString(with: .day, from: startDay)!)
        tcx.appendOpenTag(indentation: indent(level: indentationLevel), tag: tagName(), attributes: [dayAttr])
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        addProperty(forValue: notes, tcx: &tcx, tagName: "Notes", indentationLevel: indentationLevel)
    }
    

}

open class TCXExtensions: TCXElement {
    
}

typealias TCXRestrictedToken = String
//typealias TCXActivityReference = Date
