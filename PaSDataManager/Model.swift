import Foundation

class PortsAndSurveyorsData: Codable {
    let surveyors: [Surveyor]
    let ports: [Port]
    private var dictionary: [Int: Surveyor]!
    
    var surveyorsDictionary: [Int: Surveyor] {
        if dictionary != nil {
            dictionary = [Int: Surveyor](uniqueKeysWithValues: surveyors.map { ($0.id, $0) })
        }
        return dictionary
    }
    
    enum CodingKeys : String, CodingKey {
        case surveyors
        case ports
    }
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
