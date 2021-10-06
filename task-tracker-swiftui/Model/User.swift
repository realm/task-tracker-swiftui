//
//  User.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) dynamic var _id: String = UUID().uuidString
    @Persisted var _partition: String = ""
    @Persisted var name: String = ""
    @Persisted var memberOf = RealmSwift.List<Project>()

    override static func primaryKey() -> String? {
        return "_id"
    }
}
