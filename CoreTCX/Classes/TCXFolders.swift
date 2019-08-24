//
//  TCXFolders.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public protocol TCXFolderType: TCXElement {}

class TCXFolders: TCXElement {
    var history = TCXSubfolders<TCXHistoryFolder>()
    var workouts = TCXSubfolders<TCXWorkoutsFolder>()
    func f() {
        history.setMultiSport(folder: TCXMultiSportFolder())
    }
}

public class TCXSubfolders<folderType: TCXFolderType>: TCXElement {
    public var running: folderType?
    public var biking: folderType?
    public var other: folderType?
    private var multiSport: TCXMultiSportFolder?
    public var extensions: TCXExtensions?
}
extension TCXSubfolders where folderType == TCXHistoryFolder {
    func getMultiSportFolder() -> TCXMultiSportFolder? {
        return multiSport
    }
    func setMultiSport(folder: TCXMultiSportFolder?) {
        multiSport = folder
    }
}

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
    var name : String?
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
