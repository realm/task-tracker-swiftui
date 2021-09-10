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

    @State var projectName = ""
    @State var showingTasks = false
    @State var showingSheet = false
    @State var projectToOpen: Project?
    var isPreview = false

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
                            projectToOpen = project
                            showingTasks = true
                        }
                    }
                }
            }
            Spacer()
            if isPreview {
                NavigationLink( destination: TasksView(project: projectToOpen),
                                isActive: $showingTasks) {
                    EmptyView() }
            } else {
                if let realmUser = app.currentUser {
                    NavigationLink( destination: TasksView(project: projectToOpen)
                                        .environment(\.realmConfiguration, realmUser.configuration(partitionValue: projectToOpen?.partition ?? "")),
                                    isActive: $showingTasks) {
                        EmptyView() }
                }
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
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = AppState()
        state.user = .sample

        return AppearancePreviews(
            NavigationView {
                ProjectsView(isPreview: true)
                    .environmentObject(state)
            }
        )
    }
}
