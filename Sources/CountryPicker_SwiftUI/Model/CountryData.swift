//
//  CountryData.swift
//  CountryPicker_SwiftUI
//
//  Created by Maneet@MLL on 26/11/25.
//

public struct CountryData: Codable, Identifiable {
    public var id: String { code }

    public let name: String
    public let flag: String
    public let code: String
    public let dial_code: String
}
