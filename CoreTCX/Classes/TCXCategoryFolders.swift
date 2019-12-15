//
//  TCXCategoryFolders.swift
//  CoreTCX
//
//  Created by Vincent on 12/12/19.
//

import Foundation

// MARK:- Subfolders for contents

// HISTORY FOLDER

public final class TCXHistoryFolder: TCXElement, TCXFolderType {
    public var category: TCXCategoryFolderNames = .unspecified
    
    var name: String
    var folders = [TCXHistoryFolder]()
    var activityRefs = [TCXActivityReference]()
    var weeks = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
    
    override func tagName() -> String {
        return category.rawValue
    }
    
    public init(name: String) {
        self.name = name
    }
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        let nameAttr = TCXAttribute(name: "Name", value: name)
        tcx.appendOpenTag(indentation: indent(level: level), tag: tagName(), attributes: [nameAttr])
    }
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        for folder in folders {
            folder.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        for ref in activityRefs {
            ref.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        for week in weeks {
            week.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        if let notes = notes {
            addProperty(forValue: notes, tcx: &tcx, tagName: "Notes", indentationLevel: indentationLevel)
        }
        
        if let extensions = extensions {
            extensions.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
    
    
}

public final class TCXWorkoutsFolder: TCXElement, TCXFolderType {
    public var category: TCXCategoryFolderNames = .unspecified
    
    public var name: String
    public var folder = [TCXWorkoutsFolder]()
    public var workoutNameReferences = [TCXRestrictedToken]() // [min 1, max 15]chars
    var extensions: TCXExtensions?
    
    public init(name: String) {
        self.name = name
    }
    
    override func tagName() -> String {
        return category.rawValue
    }
    
    override func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        let attr = TCXAttribute(name: "Name", value: name)
        tcx.appendOpenTag(indentation: indent(level: level), tag: tagName(), attributes: [attr])
    }
    
}

public final class TCXCoursesFolder: TCXElement { // shouldn't conform to TCXFolderType
    var name: String?
    var folder = [TCXCoursesFolder]()
    var courseNameReference: TCXRestrictedToken?
    var notes: String?
    var extensions: TCXExtensions?
    
}

public final class TCXMultiSportFolder: TCXElement {
    var name: String?
    var folder = [TCXMultiSportFolder]()
    var activityReference = [TCXActivityReference]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
}

