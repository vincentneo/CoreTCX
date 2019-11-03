//
//  TCXFolders.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public protocol TCXFolderType: TCXElement {
    var type: TCXSubFolderType? { get set }
}

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

public class TCXSubfolders<folderType: TCXFolderType>: TCXElement {
    public var running: folderType?
    public var biking: folderType?
    public var other: folderType?
    public var multiSport: TCXMultiSportFolder?
    public var extensions: TCXExtensions?
    
    override func tagName() -> String {
        if folderType.self == TCXHistoryFolder.self {
            return "History"
        }
        else if folderType.self == TCXWorkoutsFolder.self {
            return "Workouts"
        }
        else {
            fatalError("Subfolder is neither History or Workouts, is againsts TCX v2 Schema.")
        }
    }
    
    override func addChildTag(toTCX tcx: NSMutableString, indentationLevel: Int) {
        
        if let running = running {
            running.type = .running
            running.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        if let biking = biking {
            biking.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        if let other = other {
            other.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        if let extensions = extensions {
            extensions.tcxTagging(tcx, indentationLevel: indentationLevel)
        }
        
        // MultiSport tag is only written if folder is of type History_t
        if folderType.self == TCXHistoryFolder.self {
            if let multiSport = multiSport {
                multiSport.tcxTagging(tcx, indentationLevel: indentationLevel)
            }
        }
    }
}

// MARK:- Subfolders for contents

public enum TCXSubFolderType {
    case running, biking, other
}

public final class TCXHistoryFolder: TCXElement, TCXFolderType {
    public var type: TCXSubFolderType?
    
    var name: String
    var folder = [TCXHistoryFolder]()
    var activityReference = [Date]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
    
    override func tagName() -> String {
        
    }
    
    required init() {
        name = "Untitled"
    }
    
    public init(name: String) {
        self.name = name
    }
    
    
}

enum TCXFolderNames: String {
    case running = "Running"
    case biking = "Biking"
    case other = "Other"
}

public final class TCXMultiSportFolder: TCXElement {
    var name: String?
    var folder = [TCXMultiSportFolder]()
    var activityReference = [TCXActivityReference]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
}

public final class TCXWorkoutsFolder: TCXElement, TCXFolderType {
    var name: String?
    var folder = [TCXWorkoutsFolder]()
    var workoutNameReference: TCXRestrictedToken?
    var extensions: TCXExtensions?
}

public final class TCXCourses: TCXElement {
    var folder: TCXCoursesFolder?
    var extensions: TCXExtensions?
}

public final class TCXCoursesFolder: TCXElement { // shouldn't conform to TCXFolderType
    var name: String?
    var folder = [TCXCoursesFolder]()
    var courseNameReference: TCXRestrictedToken?
    var notes: String?
    var extensions: TCXExtensions?
    
}
