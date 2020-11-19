//
//  OpaqueProgressView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 19/11/2020.
//

import SwiftUI

struct OpaqueProgressView: View {
    var message: String?

    init() {
        message = nil
    }

    init(_ message: String?) {
        self.message = message
    }

    var body: some View {
        VStack {
            if let message = message {
                OpaqueProgressView(message)
            } else {
                OpaqueProgressView()
            }
        }
            .padding(100)
            .background(Color("Clear"))
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

struct OpaquePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppearancePreviews(
                Group {
                    OpaqueProgressView()
                    OpaqueProgressView("Some Text")
                }
            )
        }
            .previewLayout(.sizeThatFits)
    }
}
