import Foundation

func askForSurveyor(data: PortsAndSurveyorsData) -> Surveyor {
    let maxID = data.surveyors.map { $0.id }.max() ?? 1
    let surveyorIDSet = Set(data.surveyors.map { $0.id })
    let allIDSet = Set(1...(maxID + 1))
    let idToUse = allIDSet.subtracting(surveyorIDSet).min()!
    print("Name of Surveyor: ", terminator: "")
    guard let name = readLine() else { exit(0) }
    print("Contact Details: ")
    var contacts = [String]()
    while true {
        if let line = readLine() {
            contacts.append(line)
        } else {
            break
        }
    }
}
