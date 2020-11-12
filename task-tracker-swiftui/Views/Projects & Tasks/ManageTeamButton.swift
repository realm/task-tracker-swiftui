//
//  ManageTeamButton.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI

struct ManageTeamButton: View {

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        HStack {
            Image(systemName: "person.3")
            Text("Manage Team")
            Spacer()
        }
        .padding(.leading, Dimensions.padding)
    }
}

struct ManageTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            ManageTeamButton()
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
