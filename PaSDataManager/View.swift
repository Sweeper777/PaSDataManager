import Foundation

func printSurveyor(_ surveyor: Surveyor) {
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
}

func printPort(_ port: Port) {
    print("Name: \(port.name)")
    print("Latitude: \(port.latitude)")
    print("Longitude: \(port.longitude)")
    print("Surveyors: \(port.surveyors)")
}

func printPortVerbose(_ port: Port, data: PortsAndSurveyorsData) {
    let surveyors = port.surveyors.map { data.surveyorsDictionary[$0] }
    if surveyors.contains(where: { $0 == nil }) {
        print("Unknown surveyor detected!")
        exit(0)
    }
    printPort(port)
    surveyors.forEach { print($0!) }
}

func view(args: [String], data: PortsAndSurveyorsData) {
    if args.count < 2 {
        print("At least 2 arguments expected for 'view' command!")
        exit(0)
    }
    switch args[0] {
    case "-s":
    case "-p;":
    default:
    }
}
