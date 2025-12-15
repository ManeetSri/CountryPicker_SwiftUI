//
//  Haptics.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 15/12/25.
//


import Foundation
#if canImport(UIKit)
import UIKit
#endif

enum Haptics {

    static func impact() {
        #if canImport(UIKit)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        #endif
    }
}
