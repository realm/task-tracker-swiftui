//
//  ProjectsView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct ProjectsView: View {

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
            if let projects = state.user?.memberOf {
                ForEach(projects, id: \.self) { project in
                    HStack {
                        LabeledButton(label: project.partition ?? "No partition",
                                      text: project.name ?? "No project name") {
                            showTasks(project)
                        }
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
            state.error = "Cannot get Realm config from current user"
            return
        }
        config.objectTypes = [Task.self]
        Realm.asyncOpen(configuration: config)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                state.shouldIndicateActivity = false
                if case let .failure(error) = result {
                    self.state.error = "Failed to open realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                self.tasksRealm = realm
                self.projectName = project.name ?? ""
                self.showingTasks = true
                state.shouldIndicateActivity = false
            })
            .store(in: &self.state.cancellables)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectsView()
        }
            .environmentObject(AppState())
    }
}
