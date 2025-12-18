//
//  CountryPickerViewController.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 15/12/25.
//


#if canImport(UIKit)
import UIKit
import SwiftUI

public final class CountryPickerViewController: UIViewController {

    // MARK: - State (UIKit owns it)
    private var selectedCountry: CountryData?

    private let onSelect: (CountryData) -> Void
    private let accentColor: Color

    public init(
        accentColor: Color = .blue,
        onSelect: @escaping (CountryData) -> Void
    ) {
        self.accentColor = accentColor
        self.onSelect = onSelect
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // 🔗 Create Binding manually
        let selectionBinding = Binding<CountryData?>(
            get: { [weak self] in
                self?.selectedCountry
            },
            set: { [weak self] newValue in
                self?.selectedCountry = newValue
            }
        )

        let picker = CountryPicker(
            accentColor: accentColor,
            selectedCountry: selectionBinding
        ) { [weak self] country in
            self?.onSelect(country)
            self?.dismiss(animated: true)
        }

        let host = UIHostingController(rootView: picker)

        addChild(host)
        host.view.frame = view.bounds
        host.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(host.view)
        host.didMove(toParent: self)
    }
}
#endif


