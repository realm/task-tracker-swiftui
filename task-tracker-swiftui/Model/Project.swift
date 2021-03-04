//
//  Project.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import Foundation
import RealmSwift

@objcMembers class Project: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var name: String?
    dynamic var partition: String?

    convenience init(partition: String, name: String) {
        self.init()
        self.partition = partition
        self.name = name
    }
}
