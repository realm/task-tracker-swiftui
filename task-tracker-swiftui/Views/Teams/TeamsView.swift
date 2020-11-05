//
//  TeamsView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct TeamsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState

    @State var members: [Member] = []
    @State var showingAddTeamMember = false
    @State var lastUpdate: String?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(members) { member in
                        LabeledText(label: member.id, text: member.name)
                    }
                    .onDelete(perform: removeTeamMember)
                }
                Spacer()
                if let lastUpdate = lastUpdate {
                    CaptionLabel(title: "Last updated \(lastUpdate)")
                }
            }
            .navigationBarTitle(Text("My Team"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") },
                trailing: Button(action: { self.showingAddTeamMember = true }) { Image(systemName: "plus") }
            )
        }
        .sheet(isPresented: $showingAddTeamMember) { AddTeamMemberView(refresh: fetchTeamMembers) }
        .onAppear(perform: fetchTeamMembers)
    }

    func fetchTeamMembers() {
        state.shouldIndicateActivity = true
        let user = app.currentUser!

        user.functions.getMyTeamMembers([]) { (result, error) in
            DispatchQueue.main.sync {
                state.shouldIndicateActivity = false
                guard error == nil else {
                    print("Fetch team members failed: \(error!.localizedDescription)")
                    return
                }
                print("Fetch team members complete.")
                guard let result = result else {
                    print("Result from fetching members is nil")
                    return
                }
                self.members = result.arrayValue!.map({ (bson) in
                    return Member(document: bson!.documentValue!)
                })
                let dateFormatter: DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                lastUpdate = dateFormatter.string(from: Date())
            }
        }
    }

    func removeTeamMember(at offsets: IndexSet) {
        state.shouldIndicateActivity = true
        let user = app.currentUser!
        let email = members[offsets.first!].name
        user.functions.removeTeamMember([AnyBSON(email)]) { (result, error) in
            DispatchQueue.main.sync {
                state.shouldIndicateActivity = false
                if let error = error {
                    self.state.error = "Internal error, failed to remove member: \(error.localizedDescription)"
                } else if let resultDocument = result?.documentValue {
                    if let resultError = resultDocument["error"]??.stringValue {
                        self.state.error = resultError
                    } else {
                        print("Removed team member")
                        self.fetchTeamMembers()
                    }
                } else {
                    self.state.error = "Unexpected result returned from server"
                }
            }
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamsView()
                .environmentObject(AppState())
            TeamsView()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
        }
    }
}
