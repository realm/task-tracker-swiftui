//
//  AddTeamMemberView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

// TODO: Propose a way to remove the need for these Realm functions to work with the data

import SwiftUI
import RealmSwift

struct AddTeamMemberView: View {
    let refresh: () -> Void
    @State var email = ""

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState

    private let padding: CGFloat = 16.0

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: padding) {
                    Spacer()
                    InputField(title: "email address to add",
                               text: self.$email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    CallToActionButton(
                        title: "Add Team Member",
                        action: { addTeamMember(email) })
                    Spacer()
                    if let error = state.error {
                        Text("Error: \(error)")
                            .foregroundColor(Color.red)
                    }
                }
                if state.shouldIndicateActivity {
                    OpaqueProgressView("Adding Team Member")
                }
            }
            .navigationBarTitle(Text("Add Team Member"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
            .padding(.horizontal, padding)
        }
    }

    func addTeamMember(_ email: String) {
        state.shouldIndicateActivity = true
        state.error = nil
        guard let user = app.currentUser else {
            state.shouldIndicateActivity = false
            state.error = "Can't find current user"
            return
        }
        user.functions.addTeamMember([AnyBSON(email)]) { (result, error) in
            DispatchQueue.main.sync {
                state.shouldIndicateActivity = false
                if let error = error {
                    self.state.error = "Internal error, failed to add member: \(error.localizedDescription)"
                } else if let resultDocument = result?.documentValue {
                    if let resultError = resultDocument["error"]??.stringValue {
                        self.state.error = resultError
                    } else {
                        print("Added new team member")
                        self.refresh()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    self.state.error = "Unexpected result returned from server"
                }
            }
        }
    }
}

struct AddTeamMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                AddTeamMemberView(refresh: {})
                    .environmentObject(AppState())
                Landscape(
                    AddTeamMemberView(refresh: {})
                        .environmentObject(AppState())
                )
            }
        )
    }
}
