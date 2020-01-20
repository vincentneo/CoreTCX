//
//  TCXCategoryFolders.swift
//  CoreTCX
//
//  Created by Vincent on 12/12/19.
//

import Foundation

// MARK:- Subfolders for contents

// MARK:- History Subfolder

public final class TCXHistoryFolder: TCXElement, TCXFolderType {
    public var category: TCXCategoryFolderNames = .unspecified
    
    public var name: String
    public var folders = [TCXHistoryFolder]()
    public var activityRefs = [TCXActivityReference]()
    public var weeks = [TCXWeek]()
    public var notes: String?
    public var extensions: TCXExtensions?
    
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

// MARK:- Workouts Subfolder

public final class TCXWorkoutsFolder: TCXElement, TCXFolderType {
    public var category: TCXCategoryFolderNames = .unspecified
    
    public var name: String
    public var folders = [TCXWorkoutsFolder]()
    public var nameReferences = [TCXRestrictedToken]() // [min 1, max 15]chars
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
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        for folder in folders {
            folder.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        for ref in nameReferences {
            ref.type = .workouts
            ref.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        if let extensions = extensions {
            extensions.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
    
}

// MARK:- Courses Subfolder

public final class TCXCoursesFolder: TCXElement { // shouldn't conform to TCXFolderType
    
    public var name: String
    public var folders = [TCXCoursesFolder]()
    public var nameReferences = [TCXRestrictedToken]()
    public var notes: String?
    public var extensions: TCXExtensions?
    
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
        
        for ref in nameReferences {
            ref.type = .courses
            ref.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        if let notes = notes {
            addProperty(forValue: notes, tcx: &tcx, tagName: "Notes", indentationLevel: indentationLevel)
        }
        if let extensions = extensions {
            extensions.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
    
}
