//
//  Project.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 28/10/2020.
//

import RealmSwift

class Project: EmbeddedObject {
    @objc dynamic var name: String?
    @objc dynamic var partition: String?
    convenience init(partition: String, name: String) {
        self.init()
        self.partition = partition
        self.name = name
    }
}

extension Project: Samplable {
    static var sample: Project {
        let project = Project()
        project.name = "My Project"
        project.partition = "project=489375897238957"
        return project
    }
}
