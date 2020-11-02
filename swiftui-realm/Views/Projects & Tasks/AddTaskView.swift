//
//  AddTaskView.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 29/10/2020.
//

import SwiftUI
import RealmSwift

struct AddTaskView: View {
    let realm: Realm

    @Environment(\.presentationMode) var presentationMode

    @State var error: String?
    @State var taskName = ""

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            VStack(spacing: Dimensions.padding) {
                InputField(title: "New task name",
                           text: self.$taskName)
                CallToActionButton(
                    title: "Add Task",
                    action: addTask)
                if let error = error {
                    Text("Error: \(error)")
                        .foregroundColor(Color.red)
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
            print("Missing realm configuration")
            error = "Internal error: missing Realm configuration"
            return
        }
        print("Adding new task: \(taskName) with partition \(partition)")
        let task = Task(partition: partition, name: taskName)
        do {
            try realm.write {
                realm.add(task)
                self.presentationMode.wrappedValue.dismiss()
            }
        } catch {
            print("Unable to open Realm write transaction")
        }
    }
}
