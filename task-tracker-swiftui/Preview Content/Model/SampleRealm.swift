//
//  SampleRealm.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 12/11/2020.
//

import RealmSwift

extension Realm: Samplable {
    static var sample: Realm {
        let realm = try! Realm()
        let user1: User = .sample
        let user2: User = .sample
        user2.name = "John Barnes"

        let task1: Task = .sample
        let task2: Task = .sample
        let task3: Task = .sample
        task2.name = "Think of better task name"
        task2.status = "InProgress"
        task3.name = "Think of a number"
        task3.status = "Complete"

        try! realm.write {
            realm.deleteAll()
            realm.add(user1)
            realm.add(user2)
            realm.add(task1)
            realm.add(task2)
            realm.add(task3)
        }

        return realm
    }
}
