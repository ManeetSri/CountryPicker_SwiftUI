//
//  CountryPicker+View.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 18/12/25.
//

import SwiftUI

extension CountryPicker {
    /// Header UI for `CountryPicker` containing Cancel and Done actions.
    ///
    /// This header follows native iOS picker patterns:
    /// - Cancel dismisses without committing selection
    /// - Done confirms the selected country
    var header: some View {
        HStack {
            cancelButton
            Spacer()
            doneButton
        }
        .padding(.vertical)
    }
    
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(
                    Circle()
                        .fill(Color(uiColor: .systemGray6))
                )
        }
    }
    
    var doneButton: some View {
        Button {
            if let selectedCountry {
                onSelect(selectedCountry)
                dismiss()
            }
        } label: {
            Image(systemName: "checkmark")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(
                    selectedCountry == nil ? .gray : .white
                )
                .padding(8)
                .background(
                    Circle()
                        .fill(
                            selectedCountry == nil
                            ? Color(uiColor: .systemGray4)
                            : accentColor
                        )
                )
                .animation(.easeInOut(duration: 0.2), value: selectedCountry)
        }
        .disabled(selectedCountry == nil)
    }
    
    
    /// Creates a section header used inside the country list.
    ///
    /// - Parameters:
    ///   - title: The main title of the section.
    ///   - subtitle: Optional subtitle describing the section.
    func sectionHeader(title: String, subtitle: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
            
            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .textCase(nil)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .systemBackground))
    }
    
    
    /// Search field allowing users to filter countries
    /// by name, ISO code, or dial code.
    ///
    /// Input is debounced to improve performance.
    var searchField: some View {
        TextField("Search country or code", text: $searchText)
            .padding(12)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(10)
            .onChange(of: searchText) { newValue in
                debounceSearch(newValue)
            }
    }
}
