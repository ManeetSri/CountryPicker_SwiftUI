//
//  CountryPicker.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// A SwiftUI-based country picker that allows users to search and select
/// a country along with its dial code.
///
/// `CountryPicker` supports:
/// - Searching by country name, ISO code, or dial code
/// - Auto-detection of the current region
/// - Manual confirmation via a Done button
/// - Smooth animations and haptic feedback
///
/// This view is designed to be embedded inside a sheet or modal presentation.
@available(iOS 15.0, *)
public struct CountryPicker: View {
    
    @Environment(\.dismiss) internal var dismiss
    
    /// Accent color used for selection highlights and action buttons.
    public let accentColor: Color
    
    /// Callback invoked when the user confirms a country selection.
    /// The selected `CountryData` is returned.
    public let onSelect: (CountryData) -> Void
    
    /// Internal list of all available countries loaded from JSON.
    @State internal var countries: [CountryData] = []
    
    /// Binding to the currently selected country.
    /// This allows the parent view or controller to own the selection state.
    @Binding internal var selectedCountry: CountryData?
    
    @State internal var searchText: String = ""
    @State internal var debouncedText: String = ""
    @State internal var debounceTask: Task<Void, Never>?
    
#if canImport(UIKit)
    internal let haptic = UIImpactFeedbackGenerator(style: .medium)
#endif
    
    /// Creates a new `CountryPicker`.
    ///
    /// - Parameters:
    ///   - accentColor: The color used to highlight the selected country and Done button.
    ///   - selectedCountry: A binding to the currently selected country.
    ///   - onSelect: A closure called when the user taps the Done button.
    public init(
        accentColor: Color = .blue,
        selectedCountry: Binding<CountryData?>,
        onSelect: @escaping (CountryData) -> Void
    ) {
        self.accentColor = accentColor
        self._selectedCountry = selectedCountry
        self.onSelect = onSelect
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0) {
            header
            searchField
            listView
        }
        .padding()
        .onAppear {
            loadData()
        }
        .onDisappear {
            debounceTask?.cancel()
        }
        .hideKeyboardOnTap()
    }
}
