//
//  CountryPicker+Logic.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 18/12/25.
//

import SwiftUI

extension CountryPicker {
    
    /// Debounces the search input to avoid excessive filtering.
    ///
    /// - Parameter text: The latest search text entered by the user.
    func debounceSearch(_ text: String) {
        debounceTask?.cancel()
        
        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await MainActor.run {
                debouncedText = text
            }
        }
    }
    
    /// Returns countries filtered using the debounced search text.
    var filteredCountries: [CountryData] {
        guard !debouncedText.isEmpty else { return countries }
        
        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(debouncedText) ||
            $0.code.localizedCaseInsensitiveContains(debouncedText) ||
            $0.dial_code.contains(debouncedText)
        }
    }
    
    /// Returns all countries except the currently selected one.
    var otherCountries: [CountryData] {
        guard let selectedCountry else { return filteredCountries }
        return filteredCountries.filter { $0 != selectedCountry }
    }
    
    func scrollToSelected(_ proxy: ScrollViewProxy) {
        guard let code = selectedCountry?.code else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeInOut(duration: 0.3)) {
                proxy.scrollTo(code, anchor: .center)
            }
        }
    }
}


extension CountryPicker {
    
    /// Loads country data from the bundled JSON file.
    ///
    /// Automatically selects the user's current region
    /// if no selection exists.
    func loadData() {
#if SWIFT_PACKAGE
        let bundle = Bundle.module
#else
        let bundle = Bundle.main
#endif
        
        guard let url = bundle.url(
            forResource: "countryCode",
            withExtension: "json"
        ) else {
            assertionFailure("countryCode.json not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            countries = try JSONDecoder().decode([CountryData].self, from: data)
            
            if let region = Locale.current.regionCode,
               selectedCountry?.dial_code == nil,
               let detected = countries.first(where: {
                   $0.code.uppercased() == region.uppercased()
               }) {
                selectedCountry = detected
            }
        } catch {
            print("Country picker JSON decode failed:", error)
        }
    }
}

#if canImport(UIKit)
/// Utility for dismissing the keyboard when tapping outside inputs.
extension View {
    /// Adds a gesture recognizer that dismisses the keyboard
    /// when the user taps anywhere outside a focused text field.
    func hideKeyboardOnTap() -> some View {
        simultaneousGesture(
            TapGesture().onEnded {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
        )
    }
}
#endif
