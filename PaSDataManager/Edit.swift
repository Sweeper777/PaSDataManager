import Foundation

func editSurveyor(id: Int, data: PortsAndSurveyorsData, check: Bool) {
    guard let index = data.surveyors.index(where: { $0.id == id }) else {
        print("Surveyor with ID \(id) not found!")
        exit(0)
    }
    var surveyor = data.surveyors[index]
    print("Please select the property to be edited:")
    print("1. Name")
    print("2. Contacts")
    print("3. Prices")
    switch readLine() ?? "" {
    case "1":
        print("Name of Surveyor: ", terminator: "")
        guard let name = readLine() else { exit(0) }
        surveyor.name = name
    case "2":
        print("Contact Details (type 5 asterisks to end): ")
        var contacts = [String]()
        while true {
            let line = readLine()!
            if line != "*****" {
                contacts.append(line)
            } else {
                break
            }
        }
        surveyor.contacts = contacts
    case "3":
        print("Price Details: (type 5 asterisks to end)")
        var prices = [String]()
        while true {
            let line = readLine()!
            if line != "*****" {
                prices.append(line)
            } else {
                break
            }
        }
        surveyor.prices = prices
    default:
        print("Unrecognised property!")
        exit(0)
    }
    
    data.surveyors[index] = surveyor
    
    if check {
        print("Validating data...")
        let errors = validate(data: data)
        print("Validation complete. \(errors.count) error(s) found.")
        for error in errors {
            print(error)
        }
        
        if errors.count > 0 {
            print("Changes are not saved due to having at least 1 error.")
            return
        }
    }
    
    do {
        try saveFile(data: data)
    } catch {
        print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
    }
}

func editPort(index: Int, data: PortsAndSurveyorsData, check: Bool) {
    var port = data.ports[index]
    print("Please select the property to be edited:")
    print("1. Name")
    print("2. Latitude")
    print("3. Longitude")
    print("4. Surveyors")
    
    switch readLine() ?? "" {
    case "1":
        print("Name of Port: ", terminator: "")
        guard let name = readLine() else { exit(0) }
        port.name = name
    case "2":
        print("Latitude: ", terminator: "")
        guard let latitude = readLine().map(Double.init) as? Double else { exit(0) }
        port.latitude = latitude
    case "3":
        print("Longitude: ", terminator: "")
        guard let longitude = readLine().map(Double.init) as? Double else { exit(0) }
        port.longitude = longitude
    case "4":
        print("Surveyors: (separated by commas)")
        guard let surveyorsLine = readLine() else { exit(0) }
        let surveyorIDs = surveyorsLine.split(separator: ",").compactMap { Int($0) }
        guard surveyorIDs.count > 0 else {
            print("No valid surveyor IDs")
            exit(0)
        }
        port.surveyors = surveyorIDs
    default:
        print("Unrecognised property!")
        exit(0)
    }
    
    data.ports[index] = port
    
    if check {
        print("Validating data...")
        let errors = validate(data: data)
        print("Validation complete. \(errors.count) error(s) found.")
        for error in errors {
            print(error)
        }
        
        if errors.count > 0 {
            print("Changes are not saved due to having at least 1 error.")
            return
        }
    }
    
    do {
        try saveFile(data: data)
    } catch {
        print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
    }
}

func edit(args: [String], data: PortsAndSurveyorsData) {
    if args.count < 2 {
        print("At least 2 arguments expected for 'edit' command!")
        exit(0)
    }
    switch args[0] {
    case "-s":
        guard let id = Int(args[1]) else {
            print("Invalid Surveyor ID")
            exit(0)
        }
        
        editSurveyor(id: id, data: data)
    case "-p":
        guard let i = Int(args[1]) else {
            print("Invalid Port Index")
            exit(0)
        }
        guard i < data.ports.count && i >= 0 else {
            print("Port Index Out of Range")
            exit(0)
        }
        editPort(index: i, data: data)
    default:
        print("Unrecognised argument: \(args[0])")
        exit(0)
    }
}
