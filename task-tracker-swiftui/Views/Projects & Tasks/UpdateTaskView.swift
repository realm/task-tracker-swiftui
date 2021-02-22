//
//  UpdateTaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct UpdateTaskView: View {
    @ObservedRealmObject var task: Task
    @Environment(\.realm) var realm

    @Environment(\.presentationMode) var presentationMode

    let padding: CGFloat = 16.0

    var body: some View {
        NavigationView {
            VStack(spacing: padding) {
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
            }
            .navigationBarTitle(Text("Change Task Status"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
            .padding(.horizontal, padding)
        }
    }

    func updateStatus(_ newStatus: TaskStatus) {
        do {
            try realm.write {
                task.statusEnum = newStatus
                self.presentationMode.wrappedValue.dismiss()
            }
        } catch {
            print("Unable to open Realm write transaction")
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(.sample)
        
        return Group {
            UpdateTaskView(task: task)
        }
    }
}
