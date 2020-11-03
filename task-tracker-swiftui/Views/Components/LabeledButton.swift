//
//  LabeledButton.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI

struct LabeledButton: View {
    let label: String
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            LabeledText(label: label, text: text)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LabelledButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledButton(label: "My label", text: "My Text") { print("Tap") }
            VStack {
                LabeledButton(label: "My label", text: "My Text") { print("Tap") }
            }
            .preferredColorScheme(.dark)
        }
    }
}
