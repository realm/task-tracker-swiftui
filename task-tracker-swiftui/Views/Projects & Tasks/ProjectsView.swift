//
//  ProjectsView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct ProjectsView: View {
    @ObservedObject var user: User

    @EnvironmentObject var state: AppState

    @State var tasksRealm: Realm?
    @State var projectName = ""
    @State var showingTasks = false
    @State var showingSheet = false

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        VStack(spacing: Dimensions.padding) {
            if let projects = user.memberOf {
                ForEach(projects, id: \.self) { project in
                    HStack {
                        LabeledButton(label: project.partition ?? "No partition",
                                      text: project.name ?? "No project name") {
                            showTasks(project)
                        }
                        Spacer()
                    }
                }
            }
            Spacer()
            Button(action: { self.showingSheet = true }) { ManageTeamButton() }
            if let tasksRealm = tasksRealm {
                NavigationLink( destination: TasksView(realm: tasksRealm, projectName: projectName),
                                isActive: $showingTasks) {
                    EmptyView() }
            }
        }
        .navigationBarTitle("Projects", displayMode: .inline)
        .sheet(isPresented: $showingSheet) { TeamsView() }
        .padding(.all, Dimensions.padding)
    }

    func showTasks(_ project: Project) {
        state.shouldIndicateActivity = true
        let realmConfig = app.currentUser?.configuration(partitionValue: project.partition ?? "")
        guard var config = realmConfig else {
            print("Cannot get Realm config from current user")
            return
        }
        config.objectTypes = [Task.self]
        Realm.asyncOpen(configuration: config) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Couldn't open realm: \(error)")
                    state.shouldIndicateActivity = false
                }
                return
            case .success(let realm):
                DispatchQueue.main.async {
                    self.tasksRealm = realm
                    self.projectName = project.name ?? ""
                    self.showingTasks = true
                    state.shouldIndicateActivity = false
                }
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        //        NavigationView {
        ProjectsView(user: .sample)
        //        }
    }
}
