//
//  CountryPickerModifier.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

public struct CountryPickerModifier: ViewModifier {

    @Binding var isPresented: Bool
    @Binding var selectedCountry: CountryData?
    
    let isDismissable: Bool
    let accentColor: Color
    let onSelect: (CountryData) -> Void

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                CountryPicker(
                    accentColor: accentColor,
                    selectedCountry: $selectedCountry,
                    onSelect: onSelect
                )
                .background(.white)
                .presentationDetents([.medium, .large])
                .interactiveDismissDisabled(!isDismissable)
            }
    }
}


public extension View {

    func countryPicker(
        isPresented: Binding<Bool>,
        selectedCountry: Binding<CountryData?> = .constant(nil),
        accentColor: Color = .blue,
        isDismissable: Bool = true,
        onSelect: @escaping (CountryData) -> Void
    ) -> some View {
        modifier(
            CountryPickerModifier(
                isPresented: isPresented,
                selectedCountry: selectedCountry,
                isDismissable: isDismissable,
                accentColor: accentColor,
                onSelect: onSelect
            )
        )
    }
}

