//
//  CountryPickerModifier.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

public struct CountryPickerModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    var onSelect: (CountryData) -> Void
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                CountryPicker(onSelect: onSelect)
            }
    }
}
