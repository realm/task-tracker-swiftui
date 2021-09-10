//
//  InProgressButton.swift
//  InProgressButton
//
//  Created by Andrew Morgan on 10/09/2021.
//

import SwiftUI
import RealmSwift

struct InProgressButton: View {
    @ObservedRealmObject var task: Task

    var body: some View {
        Button(action: { $task.statusEnum.wrappedValue = .InProgress }) {
            Label("In Progress", systemImage: "tornado")
        }
        .tint(.teal)
    }
}

struct InProgressButton_Previews: PreviewProvider {
    static var previews: some View {
        InProgressButton(task: .sample)
    }
}
