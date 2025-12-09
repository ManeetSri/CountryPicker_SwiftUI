//
//  SearchInputField.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 05/12/25.
//

import SwiftUI

struct SearchInputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.white)

            ZStack(alignment: .trailing) {
                Group {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .textContentType(.name)
                }
                .padding()
                .frame(height: 55)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(.red, lineWidth: 1.5)
                )
            }
        }
    }
}

#Preview {
    SearchInputField(title: "", placeholder: "", text: .constant(""))
}
