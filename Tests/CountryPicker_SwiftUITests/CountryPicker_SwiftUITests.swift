import XCTest
@testable import CountryPicker_SwiftUI

final class CountryPicker_SwiftUITests: XCTestCase {
    func testCountryDataLoading() throws {
        // This test verifies that the JSON file is correctly bundled and can be decoded
        guard let url = Bundle.module.url(forResource: "countryCode", withExtension: "json") else {
            XCTFail("Missing countryCode.json resource")
            return
        }
        
        let data = try Data(contentsOf: url)
        let countries = try JSONDecoder().decode([CountryData].self, from: data)
        
        XCTAssertFalse(countries.isEmpty, "Countries list should not be empty")
        
        // specific check
        if let output = countries.first(where: { $0.code == "US" }) {
            XCTAssertEqual(output.dial_code, "+1")
        } else {
            XCTFail("US not found in country list")
        }
    }
}
