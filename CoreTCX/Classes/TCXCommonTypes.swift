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
    
    override func addOpenTag(toTCX tcx: NSMutableString, indentationLevel: Int) {
        let attribute = NSMutableString()
        
        attribute.appendFormat(" StartDay=\"%s\"", DateConvert.toString(with: .day, from: startDay)!)
        
        tcx.appendOpenTag(indentation: indent(level: indentationLevel), tag: tagName(), attribute: attribute)
    }
}

open class TCXExtensions: TCXElement {
    
}

typealias TCXRestrictedToken = String
//typealias TCXActivityReference = Date
