//
//  TCXFolders.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public protocol TCXFolderType: TCXElement {}

// MARK:- Root Folders

class TCXFolders: TCXElement {
    var history = TCXSubfolders<TCXHistoryFolder>()
    var workouts = TCXSubfolders<TCXWorkoutsFolder>()
    var courses = TCXCourses()
    
    override func tagName() -> String {
        return "Folders"
    }
}

public class TCXSubfolders<folderType: TCXFolderType>: TCXElement {
    public var running: folderType?
    public var biking: folderType?
    public var other: folderType?
    private var multiSport: TCXMultiSportFolder?
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
}
extension TCXSubfolders where folderType == TCXHistoryFolder {
    func getMultiSportFolder() -> TCXMultiSportFolder? {
        return multiSport
    }
    func setMultiSport(folder: TCXMultiSportFolder?) {
        multiSport = folder
    }
}

// MARK:- Subfolders for contents

public final class TCXHistoryFolder: TCXElement, TCXFolderType {
    var name: String
    var folder = [TCXHistoryFolder]()
    var activityReference = [Date]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
    
    required init() {
        name = "Untitled"
    }
    
    init(name: String) {
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
