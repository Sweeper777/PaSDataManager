import Foundation

class PortsAndSurveyorsData: Codable {
    let surveyors: [Surveyor]
    let ports: [Port]
}

struct Port: Codable {
    let name: String
    let latitude, longitude: Double
    let surveyors: [Int]
}

struct Surveyor: Codable {
    let id: Int
    let name: String
    let contacts, prices: [String]
}

extension Surveyor {
    func isIdentical(to other: Surveyor) -> Bool {
        return self.name == other.name &&
            self.contacts == other.contacts &&
            self.prices == other.prices
    }
}
