//
//  User.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import RealmSwift

class User: Object {
    @objc dynamic var _id: String = UUID().uuidString
    @objc dynamic var _partition: String = ""
    @objc dynamic var name: String = ""
    let memberOf = RealmSwift.List<Project>()

    override static func primaryKey() -> String? {
        return "_id"
    }
}
