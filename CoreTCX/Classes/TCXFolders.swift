//
//  TCXFolders.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

// MARK:- Root Folders

class TCXFolders: TCXElement {
    var history: TCXSubfolders<TCXHistoryFolder>?
    var workouts: TCXSubfolders<TCXWorkoutsFolder>?
    var courses: TCXCourses?
    
    override func tagName() -> String {
        return "Folders"
    }
    
    override func addChildTag(toTCX tcx: NSMutableString, indentationLevel: Int) {
        if let history = history {
            history.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        if let workouts = workouts {
            workouts.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        
        if let courses = courses {
            courses.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
    }
    
}
