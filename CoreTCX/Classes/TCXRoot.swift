//
//  TCXRoot.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public class TCXRoot: TCXElement {
    
    var folders: TCXFolders?
    var activities: TCXActivity?
    //var workouts:
    var courses: TCXCourses?
    //var author: AbstractSource
    var extensions: TCXExtensions?
    
    // MARK: XML Schema
    
    private let xmlns = "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"
    private let xsi = "http://www.w3.org/2001/XMLSchema-instance"
    public var schemaLocation = "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd"
    
    
    // MARK: Tag Generation
    
    override func tagName() -> String {
        return "TrainingCenterDatabase"
    }
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel: Int) {
        let xmlns = TCXAttribute(name: "xmlns", value: self.xmlns)
        let xmlnsXSI = TCXAttribute(name: "xmlns:xsi", value: self.xsi)
        let location = TCXAttribute(name: "xmlns:schemaLocation", value: self.schemaLocation)
        
        tcx.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n")
        tcx.appendOpenTag(indentation: indent(level: indentationLevel), tag: tagName(), attributes: [xmlns, xmlnsXSI, location])
    }
    
}
