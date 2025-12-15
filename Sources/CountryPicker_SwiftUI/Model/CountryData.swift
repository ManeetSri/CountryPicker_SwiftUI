//
//  CountryData.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

import Foundation

public struct CountryData: Codable, Identifiable, Equatable {
    public var id: String { code }

    public let name: String
    public let flag: String
    public let code: String
    public let dial_code: String
}

public struct CountryCde: Codable {
    public let countryCode: [CountryData]
}

