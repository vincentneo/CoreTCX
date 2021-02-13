//
//  TCXFolders.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

// MARK:- Root Folders

/// `Folders_t`
public class TCXFolders: NSObject, TCXElement {
    public var history: TCXHistory?
    public var workouts: TCXWorkouts?
    public var courses: TCXCourses?
    
    func tagName() -> String {
        return "Folders"
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        if let history = history {
            history.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let workouts = workouts {
            workouts.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let courses = courses {
            courses.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
    
    
}
