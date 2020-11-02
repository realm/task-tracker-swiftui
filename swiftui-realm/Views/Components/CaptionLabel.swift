//
//  CaptionLabel.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 28/10/2020.
//

import SwiftUI

struct CaptionLabel: View {
    var title: String

    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct CaptionLabel_Previews: PreviewProvider {
    static var previews: some View {
        CaptionLabel(title: "Title")
    }
}
