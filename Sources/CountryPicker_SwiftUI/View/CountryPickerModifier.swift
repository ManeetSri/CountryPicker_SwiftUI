//
//  CountryPickerModifier.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

public struct CountryPickerModifier: ViewModifier {

    @Binding var isPresented: Bool
    
    // Optional external binding
    var externalSelection: Binding<CountryData?>?
    
    // Internal state if external binding is nil
    @State private var internalSelection: CountryData? = nil
    
    // Computed binding that uses external if available, otherwise internal
    private var selectionBinding: Binding<CountryData?> {
        externalSelection ?? $internalSelection
    }
    
    let isDismissable: Bool
    let accentColor: Color
    let onSelect: (CountryData) -> Void

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                CountryPicker(
                    accentColor: accentColor,
                    selectedCountry: selectionBinding,
                    allowAutoDismiss: true, // Auto-dismiss is enabled by default in modifier
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
        selectedCountry: Binding<CountryData?>? = nil,
        accentColor: Color = .blue,
        isDismissable: Bool = true,
        onSelect: @escaping (CountryData) -> Void
    ) -> some View {
        modifier(
            CountryPickerModifier(
                isPresented: isPresented,
                externalSelection: selectedCountry,
                isDismissable: isDismissable,
                accentColor: accentColor,
                onSelect: onSelect
            )
        )
    }
}

