//
//  ActivityIndicator.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import SwiftUI

/// Simple activity indicator to telegraph that the app is active in the background.
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        (uiView as! UIActivityIndicatorView).startAnimating()
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityIndicator()
                .preferredColorScheme(.light)
            ActivityIndicator()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
