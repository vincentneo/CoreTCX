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

class TCXHistoryFolder: TCXElement, TCXFolderType {
    var name: String
    var folder = [TCXHistoryFolder]()
    var activityReference = [Int]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
    
    required init() {
        name = "Untitled"
    }
}

class TCXMultiSportFolder: TCXElement {
    var name: String?
}

class TCXWorkoutsFolder: TCXElement, TCXFolderType {
    var name: String?
    var folder = [TCXWorkoutsFolder]()
    var workoutNameReference: String?
}

class TCXWeek: TCXElement {
    var startDay: Date?
    var notes: String?
    var extensions: TCXExtensions?
}

public class TCXExtensions: TCXElement {
    
}
