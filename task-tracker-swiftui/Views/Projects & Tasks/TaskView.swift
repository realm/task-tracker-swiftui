//
//  TaskView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct TaskView: View {
    var task: Task

    @State var showingUpdateSheet = false

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        Button(action: { self.showingUpdateSheet = true }) {
            HStack(spacing: Dimensions.padding) {
                if task.statusEnum == .Complete {
                    Text(task.name)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
                if task.statusEnum == .InProgress {
                    Text(task.name)
                        .fontWeight(.bold)
                }
                if task.statusEnum == .Open {
                    Text(task.name)
                }
                Spacer()
                if task.statusEnum == .Complete {
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.gray)
                }
                if task.statusEnum == .InProgress {
                    Image(systemName: "tornado")
                }
            }
        }
        .sheet(isPresented: $showingUpdateSheet) {
            UpdateTaskView(task: task)
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

        return Group {
            VStack {
                TaskView(task: .sample)
                TaskView(task: sample1)
                TaskView(task: sample2)
            }
            VStack {
                TaskView(task: .sample)
                TaskView(task: sample1)
                TaskView(task: sample2)
            }
            .preferredColorScheme(.dark)
        }
    }
}
