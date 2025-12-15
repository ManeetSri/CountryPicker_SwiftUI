# 🌍 CountryPicker_SwiftUI

A **lightweight, customizable country code picker** built with **SwiftUI**, packaged as a **Swift Package**, and designed specifically for **iOS apps**.

It provides a smooth, native experience with auto-detection, search, animations, haptics, and both **SwiftUI & UIKit** support.

---

## ✨ Features

- 🌍 **Auto-detect device country**
- 📌 **Selected country pinned at top**
- 🔍 **Search with debounce**
- ✅ **Animated highlight & checkmark**
- 📳 **Haptic feedback on selection**
- 🎨 **Accent color customization**
- 📦 **Swift Package Manager support**
- 🧩 **SwiftUI & UIKit compatible**
- ⚡ Optimized for large lists

---

## 📦 Installation (Swift Package Manager)

### Using Xcode

1. Open your project in Xcode
2. Go to **File → Add Packages**
3. Enter the repository URL:
   ```
   https://github.com/ManeetSri/CountryPicker_SwiftUI
   ```
4. Select **Up to Next Major Version**
5. Add `CountryPicker_SwiftUI` to your app target

---

## ✅ Requirements

- **iOS 15+**
- **Swift 5.9+**
- SwiftUI

---

## 🚀 Quick Start (SwiftUI)

```swift
import CountryPicker_SwiftUI
```

```swift
@State private var showPicker = false
@State private var selectedCountry: CountryData?

var body: some View {
    Button {
        showPicker = true
    } label: {
        HStack {
            Text(selectedCountry?.flag ?? "🌍")
            Text(selectedCountry?.dial_code ?? "+Code")
            Spacer()
            Image(systemName: "chevron.down")
        }
        .padding()
    }
    .countryPicker(
        isPresented: $showPicker,
        accentColor: .blue
    ) { country in
        selectedCountry = country
    }
}
```

---

## 🧩 UIKit Usage

```swift
import CountryPicker_SwiftUI

let pickerVC = CountryPickerViewController(
    accentColor: .systemBlue
) { country in
    print(country.name, country.dial_code)
}

pickerVC.modalPresentationStyle = .pageSheet
present(pickerVC, animated: true)
```

---

## 📜 License

MIT License
