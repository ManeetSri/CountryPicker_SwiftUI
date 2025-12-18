//
//  CountryPicker+Row.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 18/12/25.
//

import SwiftUI

extension CountryPicker {
    var listView: some View {
        ScrollViewReader { proxy in
            List {
                if let selectedCountry {
                    Section {
                        row(selectedCountry)
                            .id(selectedCountry.code)
                    } header: {
                        sectionHeader(title: "Selected Country")
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
                Section {
                    ForEach(otherCountries) { country in
                        row(country)
                            .id(country.code)
                    }
                } header: {
                    sectionHeader(
                        title: debouncedText.isEmpty ? "All Countries" : "Search Results",
                        subtitle: "\(otherCountries.count) countries"
                    )
                }.animation(.easeInOut(duration: 0.2), value: debouncedText)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .animation(.easeInOut(duration: 0.25), value: selectedCountry)
            .onAppear {
                scrollToSelected(proxy)
            }

        }
    }
}

extension CountryPicker {
    /// Builds a selectable row for a given country.
    ///
    /// - Parameter country: The country to display.
    /// - Returns: A tappable row view with selection state.
    func row(_ country: CountryData) -> some View {
        Button {
#if canImport(UIKit)
            haptic.impactOccurred()
#endif
            
            withAnimation(.easeInOut(duration: 0.25)) {
                selectedCountry = country
                searchText = ""
            }
        } label: {
            HStack(spacing: 14) {
                
                Text(country.flag)
                    .font(.system(size: 26))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(country.name)
                        .font(.system(size: 16, weight: .medium))
                    Text(country.dial_code)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if country == selectedCountry {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(accentColor)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        country == selectedCountry
                        ? accentColor.opacity(0.12)
                        : Color.clear
                    )
            )
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    country == selectedCountry
                    ? accentColor.opacity(0.12)
                    : Color.clear
                )
                .animation(.easeInOut(duration: 0.2), value: selectedCountry)
        )
    }
}
