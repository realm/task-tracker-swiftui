//
//  UpdateTaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct UpdateTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var status: TaskStatus

    let padding: CGFloat = 16.0

    var body: some View {
        NavigationView {
            VStack(spacing: padding) {
                Spacer()
                if status != .Complete {
                    CallToActionButton(
                        title: "Complete Task") {
                        updateStatus(.Complete)
                    }
                }
                if status != .Open {
                    CallToActionButton(
                        title: "Re-open Task") {
                        updateStatus(.Open)
                    }
                }
                if status != .InProgress {
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
        status = newStatus
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            UpdateTaskView(status: .constant(.Open))
        )
    }
}
