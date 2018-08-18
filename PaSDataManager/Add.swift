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
    print("Price Details: ")
    var prices = [String]()
    while true {
        if let line = readLine() {
            prices.append(line)
        } else {
            break
        }
    }
    return Surveyor(id: idToUse, name: name, contacts: contacts, prices: prices)
}

func addSurveyor(data: PortsAndSurveyorsData) {
    var surveyor: Surveyor!
    while true {
        surveyor = askForSurveyor(data: data)
        print("Please review the details:")
        printSurveyor(surveyor)
        print("Type \"revise\" to revise the data. Type anything else will add the surveyor")
        if readLine() != "revise" {
            break
        }
    }
    data.surveyors.append(surveyor)
}

func askForPort() -> Port {
    print("Name of Port: ", terminator: "")
    guard let name = readLine() else { exit(0) }
    print("Latitude: ", terminator: "")
    guard let latitude = readLine().map(Double.init) as? Double else { exit(0) }
    print("Longitude: ", terminator: "")
    guard let longitude = readLine().map(Double.init) as? Double else { exit(0) }
    print("Surveyors: (separated by commas)")
    guard let surveyorsLine = readLine() else { exit(0) }
    let surveyorIDs = surveyorsLine.split(separator: ",").compactMap { Int($0) }
    guard surveyorIDs.count > 0 else {
        print("No valid surveyor IDs")
        exit(0)
    }
    return Port(name: name, latitude: latitude, longitude: longitude, surveyors: surveyorIDs)
}

func addPort(data: PortsAndSurveyorsData) {
    var port: Port!
    while true {
        port = askForPort()
        print("Please review the details:")
        printPort(port)
        print("Type 'revise' to revise the data. Type anything else will add the port")
        if readLine() != "revise" {
            break
        }
    }
    data.ports.append(port)
}
