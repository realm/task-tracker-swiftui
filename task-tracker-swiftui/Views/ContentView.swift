//
//  ContentView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if state.loggedIn && state.user != nil {
                        if state.user != nil {
                            ProjectsView()
                        }
                    } else {
                        LoginView()
                    }
                    Spacer()
                    if let error = state.error {
                        Text("Error: \(error)")
                            .foregroundColor(Color.red)
                    }
                }
                if state.shouldIndicateActivity {
                    ActivityIndicator()
                }
            }
            .navigationBarItems(leading: state.loggedIn ? LogoutButton() : nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                ContentView()
                    .environmentObject(AppState())
                Landscape(ContentView()
                            .environmentObject(AppState()))
            }
        )
    }
}
