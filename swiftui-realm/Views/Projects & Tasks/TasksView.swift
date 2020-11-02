//
//  TasksView.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 28/10/2020.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    let realm: Realm
    let projectName: String

    @State var realmNotificationToken: NotificationToken?
    @State var tasks: Results<Task>?
    @State var lastUpdate: String?
    @State var showingSheet = false

    var body: some View {
        VStack {
            if let tasks = tasks {
                List {
                    ForEach(tasks.freeze()) { task in
                        if let tasksRealm = tasks.realm {
                            TaskView(task: (tasksRealm.resolve(ThreadSafeReference(to: task)))!)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            } else {
                Text("Loading...")
            }
            Spacer()
            if let lastUpdate = lastUpdate {
                CaptionLabel(title: "Last updated \(lastUpdate)")
            }
        }
        .navigationBarTitle("Tasks in \(projectName)", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { self.showingSheet = true }) { Image(systemName: "plus") })
        .sheet(isPresented: $showingSheet) { AddTaskView(realm: realm) }
        .onAppear(perform: loadData)
        .onDisappear(perform: stopWatching)
    }

    func loadData() {
        tasks = realm.objects(Task.self).sorted(byKeyPath: "_id")
        realmNotificationToken = realm.observe { _, _  in
            print("Task change")
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            lastUpdate = dateFormatter.string(from: Date())
        }
    }

    func stopWatching() {
        if let token = realmNotificationToken {
            token.invalidate()
        }
    }

    func deleteTask(at offsets: IndexSet) {
        do {
            try realm.write {
                guard let tasks = tasks else {
                    print("tasks not set")
                    return
                }
                realm.delete(tasks[offsets.first!])
            }
        } catch {
            print("Unable to open Realm write transaction")
        }
    }
}
