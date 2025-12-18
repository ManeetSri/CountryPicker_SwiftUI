# 🌍 CountryPicker_SwiftUI

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://swift.org/package-manager/)
[![Platform](https://img.shields.io/badge/platform-iOS_16.0+-lightgrey?style=flat-square)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=flat-square&logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)

A **lightweight, customizable country code picker** built with **SwiftUI**, packaged as a **Swift Package**, and designed specifically for **iOS apps**.

It provides a smooth, native experience with auto-detection, search, animations, haptics, and robust support for both **SwiftUI & UIKit**.

## Table of Contents

- [Demo 📱](#demo-)
- [Features 🥳](#features-)
- [Installation 💾](#installation-)
- [Usage and Integration 👩🏾‍🔬](#usage-and-integration-)
- [Customization 🎨](#customization-)
- [Contributing 🤝](#contributing-)
- [License 📜](#license-)
- [Keywords](#keywords)

---

## Demo 📱

This package provides a clean and native-feeling country picker with search and auto-detection capabilities. It supports both sheet and full-screen presentations.

## Features 🥳

- 🌍 **Auto-detect Region**: Automatically selects the user's current country based on device locale.
- 📌 **Smart Selection**: Selected country is highlighted and easily accessible.
- 🔍 **Search with Debounce**: Efficient searching by country name, ISO code, or dial code.
- ✅ **Polished UI**: Animated highlights, checkmarks, and smooth transitions.
- 📳 **Haptics**: Subtle haptic feedback on selection for a premium feel.
- 🎨 **Customizable**: Control accent colors to match your app's branding.
- 📦 **Modern Swift**: Built with Swift 5.9 and iOS 16+ APIs.
- 🧩 **Dual Support**: Seamlessly integrates into both SwiftUI and UIKit based projects.

---

## Installation 💾

### Swift Package Manager

The easiest way to install `CountryPicker_SwiftUI` is via Swift Package Manager.

1.  In Xcode, open your project and navigate to **File** → **Add Packages...**
2.  Paste the repository URL:
    ```
    https://github.com/ManeetSri/CountryPicker_SwiftUI
    ```
3.  Select **Up to Next Major Version**.
4.  Click **Add Package**.

---

## Usage and Integration 👩🏾‍🔬

### SwiftUI

You can present the `CountryPicker` using the `.countryPicker` modifier.

```swift
import SwiftUI
import CountryPicker_SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var selectedCountry: CountryData?
    
    var body: some View {
        VStack {
            Button {
                showPicker = true
            } label: {
                HStack {
                    Text(selectedCountry?.flag ?? "🌍")
                    Text(selectedCountry?.dial_code ?? "Select Country")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
        .padding()
        .countryPicker(isPresented: $showPicker, selectedCountry: $selectedCountry) { country in
            print("Selected: \(country.name)")
        }
    }
}
```

### UIKit

For UIKit apps, use the `CountryPickerViewController`.

```swift
import UIKit
import CountryPicker_SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example button tap handler
        let button = UIButton(type: .system)
        button.setTitle("Select Country", for: .normal)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
    }

    @objc func showPicker() {
        let pickerVC = CountryPickerViewController(
            accentColor: .systemBlue
        ) { [weak self] country in
            print("Selected: \(country.name) (\(country.dial_code))")
            // Handle selection (updates UI, dismisses picker, etc.)
        }
        
        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(pickerVC, animated: true)
    }
}
```

---

## Customization 🎨

The `CountryPicker` allows you to customize the **accent color** which affects the selection checkmark and UI elements.

```swift
.countryPicker(
    isPresented: $showPicker,
    accentColor: .purple, // 🟣 Custom accent color
    selectedCountry: $country
) { _ in }
```

---

## Contributing 🤝

Contributions are welcome! If you find a bug or want to add a feature, please feel free to open an issue or submit a pull request.

1.  Fork the repository.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Keywords

SwiftUI, Country Picker, iOS, Swift Package, Country Code, Dial Code, ISO Code, Flag, Mobile Number, Phone Number, UIKit, Reusable Component, Library
