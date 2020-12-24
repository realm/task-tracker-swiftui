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
            if let tasksRealm = tasksRealm {
                NavigationLink( destination: TasksView(realm: tasksRealm, projectName: projectName),
                                isActive: $showingTasks) {
                    EmptyView() }
            }
        }
        .navigationBarTitle("Projects", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: { self.showingSheet = true }) {
                    ManageTeamButton()
                }
            }
        }
        .sheet(isPresented: $showingSheet) { TeamsView() }
        .padding(.all, Dimensions.padding)
    }

    func showTasks(_ project: Project) {
        self.showingTasks = false
        state.shouldIndicateActivity = true
        let realmConfig = app.currentUser?.configuration(partitionValue: project.partition ?? "")
        guard let config = realmConfig else {
            state.error = "Cannot get Realm config from current user"
            return
        }
        Realm.asyncOpen(configuration: config)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                state.shouldIndicateActivity = false
                if case let .failure(error) = result {
                    self.state.error = "Failed to open realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("Realm Project file location: \(realm.configuration.fileURL!.path)")
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
        let state = AppState()
        state.user = .sample

        return AppearancePreviews(
                Group {
                    NavigationView {
                        ProjectsView()
                    }
                    Landscape(
                        NavigationView {
                            ProjectsView()
                        }
                    )
                }
                .environmentObject(state)
            )
    }
}
