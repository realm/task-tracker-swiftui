//
//  task_tracker_swiftuiApp.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

let app = App(id: "myapp-xxxxx") // TODO: Set the Realm application ID

@main
struct task_tracker_swiftuiApp: SwiftUI.App {
    @ObservedObject var state = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
