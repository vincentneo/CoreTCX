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
    var folder = [TCXHistoryFolder]()
    var activityRefs = [TCXActivityReference]()
    var week = [TCXWeek]()
    var notes: String?
    var extensions: TCXExtensions?
    
    override func tagName() -> String {
        return category.rawValue
    }
    
    override init() {
        name = "Untitled"
    }
    
    public init(name: String) {
        self.name = name
    }
    
    
}

public final class TCXWorkoutsFolder: TCXElement, TCXFolderType {
    public var category: TCXCategoryFolderNames = .unspecified
    
    private var preTag = ""
    
    var name: String?
    var folder = [TCXWorkoutsFolder]()
    var workoutNameReference: TCXRestrictedToken?
    var extensions: TCXExtensions?
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

