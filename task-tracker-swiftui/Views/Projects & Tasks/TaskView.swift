//
//  TaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct TaskView: View {
    @ObservedRealmObject var task: Task

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        HStack(spacing: Dimensions.padding) {
            switch task.statusEnum {
            case .Complete:
                Text(task.name)
                    .strikethrough()
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "checkmark.square")
                    .foregroundColor(.gray)
            case .InProgress:
                Text(task.name)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "tornado")
            case .Open:
                Text(task.name)
                Spacer()
            }
        }
        .padding(.horizontal, Dimensions.padding)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sample1: Task = .sample
        let sample2: Task = .sample
        sample1.statusEnum = .InProgress
        sample2.statusEnum = .Complete

        return AppearancePreviews(
            VStack {
                TaskView(task: .sample)
                TaskView(task: sample1)
                TaskView(task: sample2)
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
