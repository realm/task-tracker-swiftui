//
//  AddTaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct AddTaskView: View {
    let realm: Realm

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState

    @State var taskName = ""

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: Dimensions.padding) {
                    Spacer()
                    InputField(title: "New task name",
                               text: self.$taskName)
                    CallToActionButton(
                        title: "Add Task",
                        action: addTask)
                    Spacer()
                    if let error = state.error {
                        Text("Error: \(error)")
                            .foregroundColor(Color.red)
                    }
                }
                if state.shouldIndicateActivity {
                    OpaqueProgressView("Adding Task")
                }
            }
            .navigationBarTitle(Text("Add Task"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
            .padding(.horizontal, Dimensions.padding)
        }
    }

    func addTask() {
        guard let partition = realm.configuration.syncConfiguration?.partitionValue?.stringValue else {
            state.error = "Internal error: missing Realm configuration"
            return
        }
        let task = Task(partition: partition, name: taskName)
        do {
            try realm.write {
                realm.add(task)
                self.presentationMode.wrappedValue.dismiss()
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(realm: .sample)
            .environmentObject(AppState())
    }
}
