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
    @State var error: String?

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            VStack(spacing: Dimensions.padding) {
                Spacer()
                if task.statusEnum != .Complete {
                    CallToActionButton(
                        title: "Complete Task") {
                        updateStatus(.Complete)
                    }
                    Spacer()
                }
                if task.statusEnum != .Open {
                    CallToActionButton(
                        title: "Re-open Task") {
                        updateStatus(.Open)
                    }
                    Spacer()
                }
                if task.statusEnum != .InProgress {
                    CallToActionButton(
                        title: "Mark in Progress") {
                        updateStatus(.InProgress)
                    }
                    Spacer()
                }
                if let error = error {
                    Text("Error: \(error)")
                        .foregroundColor(Color.red)
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
        error = nil
        state.shouldIndicateActivity = true
        let realmConfig = app.currentUser?.configuration(partitionValue: task._partition)
        guard var config = realmConfig else {
            print("Internal error - cannot get Realm config")
            error = "Internal error - cannot get Realm config"
            state.shouldIndicateActivity = false
            return
        }
        config.objectTypes = [Task.self]
        Realm.asyncOpen(configuration: config) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Couldn't open realm: \(error)")
                    self.error = "Couldn't open realm: \(error)"
                    state.shouldIndicateActivity = false
                }
                return
            case .success(let realm):
                do {
                    try realm.write {
                        //                        safeTask.statusEnum = newStatus
                        task.statusEnum = newStatus
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } catch {
                    print("Unable to open Realm write transaction")
                }
            }
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView(task: .sample)
    }
}
