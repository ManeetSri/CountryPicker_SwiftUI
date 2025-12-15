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

@available(iOS 15.0, *)
public struct CountryCodePicker: View {

    @Environment(\.dismiss) private var dismiss

    // MARK: - Public
    public let accentColor: Color
    public let onSelect: (CountryData) -> Void

    // MARK: - State
    @State private var countries: [CountryData] = []
    @State private var selectedCountry: CountryData?

    @State private var searchText: String = ""
    @State private var debouncedText: String = ""
    @State private var debounceTask: Task<Void, Never>?

    #if canImport(UIKit)
    private let haptic = UIImpactFeedbackGenerator(style: .medium)
    #endif

    // MARK: - Init
    public init(
        accentColor: Color = .blue,
        onSelect: @escaping (CountryData) -> Void
    ) {
        self.accentColor = accentColor
        self.onSelect = onSelect
    }

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 12) {

            header
            searchField

            ScrollViewReader { proxy in
                List {

                    if let selectedCountry {
                        Section(header: Text("Selected")) {
                            row(selectedCountry)
                                .id(selectedCountry.code)
                        }
                    }

                    Section {
                        ForEach(otherCountries) { country in
                            row(country)
                                .id(country.code)
                        }
                    }
                }
                .listStyle(.plain)
                .onAppear {
                    scrollToSelected(proxy)
                }
            }
        }
        .padding()
        .onAppear {
            loadData()
        }
    }
}


private extension CountryCodePicker {

    var header: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
        }
    }

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


private extension CountryCodePicker {

    func row(_ country: CountryData) -> some View {
        Button {
            #if canImport(UIKit)
            haptic.impactOccurred()
            #endif

            withAnimation(.easeInOut(duration: 0.25)) {
                selectedCountry = country
            }

            onSelect(country)
            dismiss()
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
    }
}


private extension CountryCodePicker {

    func debounceSearch(_ text: String) {
        debounceTask?.cancel()

        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await MainActor.run {
                debouncedText = text
            }
        }
    }

    var filteredCountries: [CountryData] {
        guard !debouncedText.isEmpty else { return countries }

        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(debouncedText) ||
            $0.code.localizedCaseInsensitiveContains(debouncedText) ||
            $0.dial_code.contains(debouncedText)
        }
    }

    var otherCountries: [CountryData] {
        guard let selectedCountry else { return filteredCountries }
        return filteredCountries.filter { $0 != selectedCountry }
    }
}


private extension CountryCodePicker {

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
               let detected = countries.first(where: {
                   $0.code.uppercased() == region.uppercased()
               }) {
                selectedCountry = detected
            }
        } catch {
            print("Country picker JSON decode failed:", error)
        }
    }

    func scrollToSelected(_ proxy: ScrollViewProxy) {
        guard let code = selectedCountry?.code else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            proxy.scrollTo(code, anchor: .center)
        }
    }
}
