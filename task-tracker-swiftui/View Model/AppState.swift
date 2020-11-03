//
//  AppState.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import RealmSwift
import SwiftUI

class AppState: ObservableObject {
    @Published var shouldIndicateActivity = false

    var loggedIn: Bool {
        app.currentUser != nil && app.currentUser?.state == .loggedIn
    }
}
