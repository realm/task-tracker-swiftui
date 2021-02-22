//
//  SampleData.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 12/11/2020.
//

import Foundation

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
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

extension Project: Samplable {
    static var sample: Project {
        let project = Project()
        project.name = "My Project"
        project.partition = "project=489375897238957"
        return project
    }
}

extension Task: Samplable {
    static var sample: Task {
        let task = Task()
        task.name = "My Task"
        task._partition = "project=489375897238957"
        task.owner = "Fred Flinstone"
        task.status = "In progress"
        return task
    }

    convenience init (_ task: Task) {
        self.init()
        name = task.name
        _partition = task._partition
        owner = task.owner
        status = task.status
    }
}
