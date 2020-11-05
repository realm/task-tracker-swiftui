//
//  SignupView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState
    @State private var username = ""
    @State private var password = ""

    private enum Dimensions {
        static let topInputFieldPadding: CGFloat = 32.0
        static let buttonPadding: CGFloat = 24.0
        static let topPadding: CGFloat = 48.0
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
                title: "Sign Up",
                action: { self.signup(username: self.username, password: self.password) })
        }
        .padding(.horizontal, Dimensions.padding)
    }

    private func signup(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            return
        }
        self.state.error = nil
        state.shouldIndicateActivity = true
        app.emailPasswordAuth.registerUser(email: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                state.shouldIndicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            .store(in: &state.cancellables)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
            .environmentObject(AppState())
            SignupView()
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
        }
    }
}
