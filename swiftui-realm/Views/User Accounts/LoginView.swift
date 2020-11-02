//
//  LoginView.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @Binding var user: User?

    @EnvironmentObject var state: AppState
    @State var error: String?
    @State private var username = ""
    @State private var password = ""

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        VStack(spacing: Dimensions.padding) {
            InputField(title: "Email/Username",
                       text: self.$username)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            InputField(title: "Password",
                       text: self.$password,
                       showingSecureField: true)
            CallToActionButton(
                title: "Log In",
                action: { self.login(username: self.username, password: self.password) })
            NavigationLink(
                destination: SignupView(),
                label: {
                    Text("Register new user")
                })
            if let error = error {
                Text("Error: \(error)")
                    .foregroundColor(Color.red)
            }
        }
        .padding(.horizontal, Dimensions.padding)
    }

    private func login(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            return
        }
        self.error = nil
        state.shouldIndicateActivity = true
        app.login(credentials: .emailPassword(email: username, password: password)) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.state.shouldIndicateActivity = false
                    print("Login failed: \(error)")
                    self.error = "Login failed: \(error.localizedDescription)"
                    return
                case .success(let user):
                    print("Logged in")
                    var realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                    realmConfig.objectTypes = [User.self, Project.self]
                    Realm.asyncOpen(configuration: realmConfig) { result in
                        DispatchQueue.main.async {
                            self.state.shouldIndicateActivity = false
                            switch result {
                            case .failure(let error):
                                print("Failed to open Realm: \(error.localizedDescription)")
                                self.error = "Failed to open Realm: \(error.localizedDescription)"
                                user.logOut { error in
                                    DispatchQueue.main.async {
                                        self.error = "Failed to open Realm. Try logging in again"
                                    }
                                }
                            case .success(let realm):
                                print("Opened Realm")
                                let user = realm.objects(User.self).first
                                if user == nil {
                                    print("Did not find a User Object")
                                } else {
                                    print("Storing User")
//                                    self.state.currentUser =  user
                                    self.user =  user
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(user: .constant(.sample))
                .environmentObject(AppState())
                .preferredColorScheme(.light)
            LoginView(user: .constant(.sample))
                .preferredColorScheme(.dark)
                .environmentObject(AppState())
        }
    }
}
