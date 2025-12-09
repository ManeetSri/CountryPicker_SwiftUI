# CountryPicker_SwiftUI

A simple, lightweight, and easy-to-use Country Picker for SwiftUI applications.

## Features

- 🌍 **Comprehensive Country List**: Access a full list of countries with their details.
- 🏳️ **Flags**: Display country flags.
- 📞 **Dial Codes**: Retrieve international dial codes.
- 🎨 **SwiftUI Native**: Built entirely with SwiftUI for seamless integration.
- 🧩 **Easy Integration**: Simple modifier-based usage.

## Requirements

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

You can install `CountryPicker_SwiftUI` via Swift Package Manager.

1. In Xcode, go to **File > Add Packages...**
2. Enter the URL of your repository.
3. Select the version you want to use.

Alternatively, add it to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/CountryPicker_SwiftUI.git", from: "1.0.0")
]
```

## Usage

### 1. Import the Package

```swift
import CountryPicker_SwiftUI
```

### 2. Use the Modifier

The easiest way to present the country picker is using the `.modifier` or creating a custom extension.

```swift
struct ContentView: View {
    @State private var showCountryPicker = false
    @State private var selectedCountry: CountryData?

    var body: some View {
        VStack(spacing: 20) {
            if let country = selectedCountry {
                Text("Selected: \(country.flag) \(country.name) (\(country.dial_code))")
                    .font(.title)
            } else {
                Text("Select a Country")
                    .font(.title)
            }
            
            Button("Pick Country") {
                showCountryPicker = true
            }
            .buttonStyle(.borderedProminent)
        }
        .modifier(CountryPickerModifier(isPresented: $showCountryPicker, onSelect: { country in
            self.selectedCountry = country
            // The picker will dismiss automatically or you can handle it here
        }))
    }
}
```

### 3. Country Data Model

The `CountryData` struct provides the following properties:

```swift
public struct CountryData: Codable, Identifiable {
    public let name: String      // e.g., "United States"
    public let flag: String      // e.g., "🇺🇸"
    public let code: String      // e.g., "US"
    public let dial_code: String // e.g., "+1"
}
```

## Customization

(Optional: Add details here if you add customization options like filtering, styling, etc.)

## License

This project is licensed under the MIT License.
