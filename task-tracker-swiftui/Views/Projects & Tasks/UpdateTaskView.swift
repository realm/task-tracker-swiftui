//
//  UpdateTaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct UpdateTaskView: View {
    var task: Task

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: Dimensions.padding) {
                    Spacer()
                    if task.statusEnum != .Complete {
                        CallToActionButton(
                            title: "Complete Task") {
                            updateStatus(.Complete)
                        }
                    }
                    if task.statusEnum != .Open {
                        CallToActionButton(
                            title: "Re-open Task") {
                            updateStatus(.Open)
                        }
                    }
                    if task.statusEnum != .InProgress {
                        CallToActionButton(
                            title: "Mark in Progress") {
                            updateStatus(.InProgress)
                        }
                    }
                    Spacer()
                    if let error = state.error {
                        Text("Error: \(error)")
                            .foregroundColor(Color.red)
                    }
                }
                if state.shouldIndicateActivity {
                    OpaqueProgressView("Updating Task")
                }
            }
            .navigationBarTitle(Text("Change Task Status"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
            .padding(.horizontal, Dimensions.padding)
        }
    }

    func updateStatus(_ newStatus: TaskStatus) {
        state.error = nil
        state.shouldIndicateActivity = true
        let realmConfig = app.currentUser?.configuration(partitionValue: task._partition)
        guard var config = realmConfig else {
            state.error = "Internal error - cannot get Realm config"
            state.shouldIndicateActivity = false
            return
        }
        config.objectTypes = [Task.self]
        Realm.asyncOpen(configuration: config) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state.error = "Couldn't open realm: \(error)"
                    state.shouldIndicateActivity = false
                }
                return
            case .success(let realm):
                do {
                    try realm.write {
                        task.statusEnum = newStatus
                        state.shouldIndicateActivity = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } catch {
                    state.error = "Unable to open Realm write transaction"
                }
            }
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpdateTaskView(task: .sample)
        }
        .environmentObject(AppState())
    }
}
