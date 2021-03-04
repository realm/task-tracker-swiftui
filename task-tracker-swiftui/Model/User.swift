//
//  User.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import Foundation
import RealmSwift

@objcMembers class User: Object, ObjectKeyIdentifiable {
    dynamic var _id: String = UUID().uuidString
    dynamic var _partition: String = ""
    dynamic var name: String = ""
    let memberOf = RealmSwift.List<Project>()

    override static func primaryKey() -> String? {
        return "_id"
    }
}
