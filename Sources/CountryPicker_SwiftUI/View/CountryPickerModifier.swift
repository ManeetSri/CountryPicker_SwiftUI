//
//  CountryPickerModifier.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

public struct CountryPickerModifier: ViewModifier {

    @Binding var isPresented: Bool
    let accentColor: Color
    let onSelect: (CountryData) -> Void

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                CountryCodePicker(
                    accentColor: accentColor,
                    onSelect: onSelect
                )
                .presentationDetents([.medium, .large])
            }
    }
}


public extension View {

    func countryPicker(
        isPresented: Binding<Bool>,
        accentColor: Color = .blue,
        onSelect: @escaping (CountryData) -> Void
    ) -> some View {
        modifier(
            CountryPickerModifier(
                isPresented: isPresented,
                accentColor: accentColor,
                onSelect: onSelect
            )
        )
    }
}

