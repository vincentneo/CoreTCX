//
//  TCXCategoryFolders.swift
//  CoreTCX
//
//  Created by Vincent on 12/12/19.
//

import Foundation

// MARK:- Subfolders for contents

// MARK:- History Subfolder

/// `HistoryFolder_t`
public final class TCXHistoryFolder: TCXFolderType {
    //public var category: TCXCategoryFolderNames = .unspecified
    //override var category: TCXCategoryFolderNames
    public var name: String
    public var folders = [TCXHistoryFolder]()
    public var activityRefs = [TCXActivityReference]()
    public var weeks = [TCXWeek]()
    public var notes: String?
    public var extensions: TCXExtensions?
    
    public override func tagName() -> String {
        return category.rawValue
    }
    
    public init(name: String) {
        self.name = name
    }
    override func tcxTagging(_ tcx: inout String, indentationLevel: Int) {
        addOpenTag(toTCX: &tcx, indentationLevel: indentationLevel)
        addChildTag(toTCX: &tcx, indentationLevel: indentationLevel + 1)
        addCloseTag(toTCX: &tcx, indentationLevel: indentationLevel)
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
    
    override func addCloseTag(toTCX tcx: inout String, indentationLevel: Int) {
        tcx.append(String(format: "%@</%@>\r\n", indent(level: indentationLevel), self.tagName()))
    }
}

// MARK:- Workouts Subfolder

/// `Workouts_t`
public final class TCXWorkoutsFolder: TCXFolderType {
    
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
    
    override func addCloseTag(toTCX tcx: inout String, indentationLevel: Int) {
        tcx.append(String(format: "%@</%@>\r\n", indent(level: indentationLevel), self.tagName()))
    }
    
}

// MARK:- Courses Subfolder

/// `CourseFolder_t`
public final class TCXCoursesFolder: TCXElement {
    func tagName() -> String {
        return ""
    }
    // shouldn't conform to TCXFolderType
    
    public var name: String
    public var folders = [TCXCoursesFolder]()
    public var nameReferences = [TCXRestrictedToken]()
    public var notes: String?
    public var extensions: TCXExtensions?
    
    public init(name: String) {
        self.name = name
    }
    
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        let nameAttr = TCXAttribute(name: "Name", value: name)
        
        tcx.appendOpenTag(indentation: indent(level: level), tag: tagName(), attributes: [nameAttr])
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
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
