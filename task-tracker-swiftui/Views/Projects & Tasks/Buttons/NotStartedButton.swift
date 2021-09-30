//
//  NotStartedButton.swift
//  NotStartedButton
//
//  Created by Andrew Morgan on 10/09/2021.
//

import SwiftUI
import RealmSwift

struct NotStartedButton: View {
    @ObservedRealmObject var task: Task

    var body: some View {
        Button(action: { $task.statusEnum.wrappedValue = .Open }) {
            Label("Not Started", systemImage: "stop")
        }
        .tint(.brown)
    }
}

struct NotStartedButton_Previews: PreviewProvider {
    static var previews: some View {
        NotStartedButton(task: .sample)
    }
}
