//
//  LogoutView.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import SwiftUI

/// A button that handles logout requests.
struct LogoutButton: View {
    @EnvironmentObject var state: AppState
    var body: some View {
        Button("Log Out") {
            state.shouldIndicateActivity = true
            app.currentUser?.logOut { _ in
                DispatchQueue.main.async {
                    print("Logged out")
                    self.state.shouldIndicateActivity = false
                }
            }
        }
            .disabled(state.shouldIndicateActivity)
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogoutButton()
                .environmentObject(AppState())
                .preferredColorScheme(.light)
            LogoutButton()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
        }
    }
}
