//
//  CompleteButton.swift
//  CompleteButton
//
//  Created by Andrew Morgan on 10/09/2021.
//

import SwiftUI
import RealmSwift

struct CompleteButton: View {
    @ObservedRealmObject var task: Task

    var body: some View {
        Button(action: { $task.statusEnum.wrappedValue = .Complete }) {
            Label("Complete", systemImage: "checkmark")
        }
        .tint(.green)
    }
}

struct CompleteButton_Previews: PreviewProvider {
    static var previews: some View {
        CompleteButton(task: .sample)
    }
}
