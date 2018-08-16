import Foundation

func printSurveyor(_ surveyor: Surveyor) {
    printSeparator(withColor: .cyan)
    print("Name: \(surveyor.name)")
    print("ID: \(surveyor.id)")
    print("Contacts:")
    for line in surveyor.contacts {
        print(line)
    }
    print("Prices:")
    for line in surveyor.prices {
        print(line)
    }
    printSeparator(withColor: .cyan)
}

func printPort(_ port: Port) {
    printSeparator(withColor: .yellow)
    print("Name: \(port.name)")
    print("Latitude: \(port.latitude)")
    print("Longitude: \(port.longitude)")
    print("Surveyors: \(port.surveyors)")
    printSeparator(withColor: .yellow)
}

func printPortVerbose(_ port: Port, data: PortsAndSurveyorsData) {
    printSeparator(withColor: .yellow)
    let surveyors = port.surveyors.map { data.surveyorsDictionary[$0] }
    if surveyors.contains(where: { $0 == nil }) {
        print("Unknown surveyor detected!")
        exit(0)
    }
    printPort(port)
    surveyors.forEach { printSurveyor($0!) }
    printSeparator(withColor: .yellow)
}

func view(args: [String], data: PortsAndSurveyorsData) {
    if args.count < 2 {
        print("At least 2 arguments expected for 'view' command!")
        exit(0)
    }
    switch args[0] {
    case "-s":
        guard let id = Int(args[1]), let surveyor = data.surveyorsDictionary[id] else {
            print("Invalid Surveyor ID")
            exit(0)
        }
        
        printSurveyor(surveyor)
    case "-p":
        guard let i = Int(args[1]) else {
            print("Invalid Port Index")
            exit(0)
        }
        guard i < data.ports.count && i >= 0 else {
            print("Port Index Out of Range")
            exit(0)
        }
        if args.count > 2 && args[2] == "-v" {
            printPortVerbose(data.ports[i], data: data)
        } else {
            printPort(data.ports[i])
        }
    default:
        print("Unrecognised argument: \(args[0])")
        exit(0)
    }
}
