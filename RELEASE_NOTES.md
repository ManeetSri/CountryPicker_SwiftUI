# v1.0.0 - Initial Release 🚀

We are excited to announce the first major release of `CountryPicker_SwiftUI`! This library provides a polished, native-feeling country code picker for iOS applications, supporting both SwiftUI and UIKit.

## ✨ Key Features

- **🌍 Auto-Detect Region**: automatically identifies and selects the user's country based on their device locale.
- **🔍 Smart Search**: Quickly find countries by name, ISO code, or dial code with built-in debouncing.
- **🎨 Customization**: Easily match your app's branding with custom accent colors.
- **✅ Dual Support**: Seamlessly integrates with both **SwiftUI** (via modifier) and **UIKit** (via ViewController).
- **📳 Haptic Feedback**: Subtle haptics for a premium user experience.
- **📱 Modern UI**: Smooth animations, glassmorphism elements, and native sheet presentations.

## 🛠 Installation

Add the package via Swift Package Manager:

```
https://github.com/ManeetSri/CountryPicker_SwiftUI
```

## 👩🏾‍🔬 Usage

### SwiftUI
```swift
.countryPicker(isPresented: $showPicker, selectedCountry: $country) { selected in
    print(selected.name)
}
```

### UIKit
```swift
let picker = CountryPickerViewController()
present(picker, animated: true)
```

--

*Built with ❤️ for the Swift community.*
