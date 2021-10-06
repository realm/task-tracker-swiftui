//
//  Project.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import Foundation
import RealmSwift

class Project: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var name: String?
    @Persisted var partition: String?

    convenience init(partition: String, name: String) {
        self.init()
        self.partition = partition
        self.name = name
    }
}
