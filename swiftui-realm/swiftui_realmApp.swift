//
//  swiftui_realmApp.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import SwiftUI
import RealmSwift

let app = App(id: "myrealmapp-xxxxx") // TODO: Set the Realm application ID

@main
struct swiftui_realmApp: SwiftUI.App {
    @ObservedObject var state = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(state)
        }
    }
}
