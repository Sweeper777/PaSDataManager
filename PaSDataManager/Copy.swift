import Foundation
import AppKit

func copyDataToClipboard(data: PortsAndSurveyorsData) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(data)
        let jsonString = String(data: data, encoding: .utf8)!
        NSPasteboard.general.declareTypes([.string], owner: nil)
        if NSPasteboard.general.setString(jsonString, forType: .string) {
            print("JSON data is successfully copied to clipboard!")
        } else {
            print("An error occurred. Data is not copied to clipboard.")
        }
    } catch {
        print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
    }
}
