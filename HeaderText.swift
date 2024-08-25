//
//  ContentView.swift
//  YandexFastTrack
//
//  Created by Kamil Suleymanov on 24.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tappedLocation: CGPoint = .zero
    var body: some View {
        HeaderText(
            buttonText: "Button",
            buttonFont: .systemFont(ofSize: 18),
            text: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque quis hendrerit justo, id semper risus. Aliquam sollicitudin turpis sed tempus porta. Sed eu erat nunc. Cras imperdiet luctus venenatis. Suspendisse sagittis faucibus lacus et ullamcorper. Maecenas eu consequat nisi. In sodales nec dolor ac imperdiet. Suspendisse ut convallis lorem. Ut at nisl et nulla condimentum mattis. Maecenas ornare, ante tincidunt tincidunt efficitur, tortor purus tristique mi, sed tincidunt eros ligula quis risus. Vivamus velit mi, rhoncus ut justo non, scelerisque vulputate eros. Nullam laoreet velit eros, eu facilisis ex suscipit ut. Donec ac tempor ex.
"""
        ) {
            print(#function)
        }
    }

}

#Preview {
    ContentView()
}

struct HeaderText: View {
    let buttonText: String
    let buttonFont: UIFont
    var buttonColor: Color = .blue
    let text: String
    let buttonAction: () -> Void

    private var buttonSize: CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: buttonFont]
        let attributedString = NSAttributedString(string: buttonText, attributes: attributes)
        let size = attributedString.boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    private var buildAttributedString: AttributedString {
        var attributedString = AttributedString(" ")
        var buttonText = AttributedString(buttonText)
        buttonText.foregroundColor = buttonColor
        buttonText.font = buttonFont

        attributedString.append(buttonText)

        let whiteSpace = AttributedString(" ")
        attributedString.append(whiteSpace)

        let remainingText = AttributedString(text)

        attributedString.append(remainingText)
        return attributedString
    }

    var body: some View {
        Text(buildAttributedString)
            .gesture(
                DragGesture(minimumDistance: .zero)
                    .onEnded { value in
                        guard value.location.x <= buttonSize.width && value.location.y <= buttonSize.height else { return }
                        buttonAction()
                    }
            )
    }
}
