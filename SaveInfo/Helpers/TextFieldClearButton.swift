//
//  TextFieldClearButton.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//

import SwiftUI

struct ClearButtonTextFieldModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack(alignment: .top) {
            content
            
            Button {
                    text = ""
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                    // Animate scale and opacity together
                    .scaleEffect(text.isEmpty ? 0.5 : 1)
                    .opacity(text.isEmpty ? 0 : 1)
                    .animation(.snappy(duration: 0.25), value: text)
            }
            // Disable button hit testing when text is empty
            .disabled(text.isEmpty)
        }
    }
}

extension View {
    func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButtonTextFieldModifier(text: text))
    }
}
