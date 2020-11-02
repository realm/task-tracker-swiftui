//
//  User.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 28/10/2020.
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

extension User: Samplable {
    static var sample: User {
        let user = User()
        user._partition = "dummy-partition"
        user.name = "Fred Flinstone"
        user.memberOf.append(.sample)
        let project2: Project = .sample
        project2.name = "Another project"
        user.memberOf.append(project2)
        return user
    }
}
