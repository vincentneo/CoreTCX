//
//  TCXSubfolders.swift
//  CoreTCX
//
//  Created by Vincent on 12/12/19.
//

import Foundation

public protocol TCXFolderType: TCXElement {
    var category: TCXCategoryFolderNames { get set }
    //var categoryTag: TCXCategoryFolderNames { get }
}
extension TCXFolderType {
    public var category: TCXCategoryFolderNames {
        get { return .unspecified }
    }
}

public enum TCXCategoryFolderNames: String {
    case running = "Running"
    case biking = "Biking"
    case other = "Other"
    case unspecified = "Unknown"
}

public class TCXSubfolders<folderType: TCXFolderType>: TCXElement {
    public var running: folderType?
    public var biking: folderType?
    public var other: folderType?
    public var multiSport: TCXMultiSportFolder?
    public var extensions: TCXExtensions?
    
    /// Only call when tagging.
    private func autoTagCategories() {
        running?.category = .running
        biking?.category = .biking
        other?.category = .other
    }
    
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
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        if let running = running {
            //running.type = .running
            running.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let biking = biking {
            biking.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let other = other {
            other.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let extensions = extensions {
            extensions.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        
        // MultiSport tag is only written if folder is of type History_t
        if folderType.self == TCXHistoryFolder.self {
            if let multiSport = multiSport {
                multiSport.tcxTagging(&tcx, indentationLevel: indentationLevel)
            }
        }
    }
    
}

public final class TCXCourses: TCXElement {
    var folder: TCXCoursesFolder?
    var extensions: TCXExtensions?
}

