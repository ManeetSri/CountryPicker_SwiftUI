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

        let picker = CountryCodePicker(
            accentColor: accentColor
        ) { [weak self] country in
            self?.dismiss(animated: true)
            self?.onSelect(country)
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

