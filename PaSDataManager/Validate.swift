import Foundation

@discardableResult
func validate(data portsAndSurveyorsData: PortsAndSurveyorsData) -> [String] {
    var errors = [String]()
    
    // duplicate ids
    let surveyorIds = portsAndSurveyorsData.surveyors.map { $0.id }
    var idSet = Set<Int>()
    for id in surveyorIds {
        if !idSet.insert(id).inserted {
            errors.append("Surveyor ID \(id) appears more than once!")
        }
    }
    
    // ports no duplicate
    let portNames = portsAndSurveyorsData.ports.map { $0.name }
    var nameSet = Set<String>()
    for name in portNames {
        if !nameSet.insert(name).inserted {
            errors.append("Port name \"\(name)\" appears more than once!")
        }
    }
    
    // ports have surveyors
    for port in portsAndSurveyorsData.ports {
        if port.surveyors.isEmpty {
            errors.append("Port \"\(port.name)\" has no surveyors!")
        }
    }
    
    // ports have existent surveyors
    for port in portsAndSurveyorsData.ports {
        for surveyorId in port.surveyors {
            if !surveyorIds.contains(surveyorId) {
                errors.append("Port \"\(port.name)\" has a non-existent surveyor: \(surveyorId)!")
            }
        }
    }
    
    // ports have duplicate surveyors
    for port in portsAndSurveyorsData.ports {
        if Set(port.surveyors).count != port.surveyors.count {
            errors.append("Port \"\(port.name)\" has duplicate surveyors!")
        }
    }
    
    // identical surveyors
    for i in 0..<portsAndSurveyorsData.surveyors.count {
        for j in 0..<portsAndSurveyorsData.surveyors.count where j != i {
            if portsAndSurveyorsData.surveyors[i].isIdentical(to: portsAndSurveyorsData.surveyors[j]) {
                errors.append("Surveyor ID \(portsAndSurveyorsData.surveyors[i].id) is identical to surveyor ID \(portsAndSurveyorsData.surveyors[j].id)")
            }
        }
    }
    
    // surveyors without price or contacts
    for surveyor in portsAndSurveyorsData.surveyors {
        if surveyor.contacts.filter({ $0.trimmingCharacters(in: CharacterSet.whitespaces) != ""}).count == 0 {
            errors.append("Surveyor ID \(surveyor.id) has no contact info!")
        }
        if surveyor.prices.filter({ $0.trimmingCharacters(in: CharacterSet.whitespaces) != ""}).count == 0 {
            errors.append("Surveyor ID \(surveyor.id) has no price info!")
        }
    }
    return errors
}
