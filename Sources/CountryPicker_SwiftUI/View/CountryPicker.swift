//
//  CountryPicker.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import SwiftUI

struct CountryCodePicker: View {
    
    @State var countries: [CountryData] = []
    @State var searchCountry: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    public var onSelect: (CountryData) -> Void
    
    public init(onSelect: @escaping (CountryData) -> Void) {
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.white)
                }).buttonStyle(.plain)
            }
            //            VibTextField(title: "", placeholder: "Search Country", inputType: .name, errorMessage: nil, text: $searchCountry)
//            SearchInputField()
            List(filteredCountries, id: \.id) { item in
                Button {
                    //                                onSelect(item)
                    //                                dismiss()
                } label: {
                    HStack(spacing: 14) {
                        Text(item.flag)
                            .font(.system(size: 28))
                            .foregroundStyle(.white)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            Text(item.dial_code)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear {
            loadData()
        }
    }
    
    private var filteredCountries: [CountryData] {
        if searchCountry.isEmpty { return countries }
        return countries.filter {
            $0.name.lowercased().contains(searchCountry.lowercased()) ||
            $0.dial_code.contains(searchCountry)
        }
    }
    
    private func loadData() {
        guard let codeData = Bundle.main.url(forResource: "countryCode", withExtension: "json") else {
            print("Country Code data not available")
            return
        }
        
        do {
            let data = try Data(contentsOf: codeData)
            let model = try JSONDecoder().decode([CountryData].self, from: data)
            countries = model
        } catch {
            print("Failed to decode JSON:", error)
        }
    }
}
