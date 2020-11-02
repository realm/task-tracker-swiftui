//
//  ContentView.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: AppState
    @State var user: User?

    var body: some View {
        NavigationView {
            ZStack {
                if state.loggedIn && user != nil {
                    if let user = user {
                        ProjectsView(user: user)
                    }
                } else {
                    LoginView(user: $user)
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
        Group {
            ContentView()
                .environmentObject(AppState())
                .preferredColorScheme(.light)
            ContentView()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
        }
    }
}
