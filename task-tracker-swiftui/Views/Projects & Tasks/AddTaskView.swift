//
//  AddTaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct AddTaskView: View {
    @ObservedResults(Task.self) var tasks

    @Environment(\.presentationMode) var presentationMode

    let partition: String

    @State var taskName = ""

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            VStack(spacing: Dimensions.padding) {
                Spacer()
                InputField(title: "New task name",
                           text: self.$taskName)
                CallToActionButton(
                    title: "Add Task",
                    action: {
                        let task = Task(partition: partition, name: taskName)
                        $tasks.append(task)
                        self.presentationMode.wrappedValue.dismiss()
                    })
                Spacer()
            }
        }
        .navigationBarTitle(Text("Add Task"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
        .padding(.horizontal, Dimensions.padding)
    }

//    func addTask() {
//        let task = Task(project: project, name: taskName)
//        $tasks.append(task)
//        self.presentationMode.wrappedValue.dismiss()
//    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return AddTaskView(partition: "Doesn't matter")
    }
}
