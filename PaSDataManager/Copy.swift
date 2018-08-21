import Foundation
import AppKit

func copyDataToClipboard(data: PortsAndSurveyorsData) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(data)
        let jsonString = String(data: data, encoding: .utf8)!
        NSPasteboard.general.setString(jsonString, forType: NSPasteboard.PasteboardType.fileContentsType(forPathExtension: "json"))
        print("JSON data is successfully copied to clipboard!")
    } catch {
        print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
    }
}
