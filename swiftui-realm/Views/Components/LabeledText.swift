//
//  LabeledText.swift
//
//  Created on 27/03/2020.
//  Copyright © 2020 WildAid. All rights reserved.
//

import SwiftUI

struct LabeledText: View {
    var label: String
    var text: String

    let lineLimit = 5

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            CaptionLabel(title: label)
            Text("\(text)")
                .font(.body)
                .lineLimit(lineLimit)
        }
    }
}

struct LabeledText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack(alignment: .top) {
                LabeledText(label: "Label", text: "0.72367628765")
                LabeledText(label: "Date", text: "")
            }
            HStack(alignment: .top) {
                LabeledText(label: "Label", text: "0.72367628765")
                LabeledText(label: "Date", text: "")
            }
            .preferredColorScheme(.dark)
        }
    }
}
