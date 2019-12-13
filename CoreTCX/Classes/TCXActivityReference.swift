//
//  TCXActivityRef.swift
//  CoreTCX
//
//  Created by Vincent on 13/12/19.
//

import Foundation

public class TCXActivityReference: TCXElement {
    
    public var id: Date
    
    public init(activityRefId: Date) {
        id = activityRefId
    }
    
    override func addChildTag(toTCX tcx: NSMutableString, indentationLevel: Int) {
        guard let formattedDate = DateConvert.toString(with: .ISO8601, from: id) else { return }
        
        addProperty(forValue: formattedDate, gpx: tcx, tagName: "Id", indentationLevel: indentationLevel)
    }
}
