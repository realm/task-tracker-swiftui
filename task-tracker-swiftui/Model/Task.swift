//
//  Task.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import Foundation
import RealmSwift

enum TaskStatus: String {
    case Open
    case InProgress
    case Complete
}

@objcMembers class Task: Object, ObjectKeyIdentifiable {
    dynamic var _id: ObjectId = ObjectId.generate()
    dynamic var _partition: String = ""
    dynamic var name: String = ""
    dynamic var owner: String?
    dynamic var status: String = ""
    override static func primaryKey() -> String? {
        return "_id"
    }

    var statusEnum: TaskStatus {
        get {
            return TaskStatus(rawValue: status) ?? .Open
        }
        set {
            status = newValue.rawValue
        }
    }

    convenience init(partition: String, name: String) {
        self.init()
        self._partition = partition
        self.name = name
        self.statusEnum = .Open
    }
}

extension Task: Identifiable {
    var id: String {
        _id.stringValue
    }
}

struct Member: Identifiable {
    let id: String
    let name: String

    init(document: Document) {
        self.id = document["_id"]!!.stringValue!
        self.name = document["name"]!!.stringValue!
    }
}
