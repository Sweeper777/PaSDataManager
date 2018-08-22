import Foundation

func deleteSurveyor(id: Int, data: PortsAndSurveyorsData, check: Bool) {
    guard let index = data.surveyors.index(where: { $0.id == id }) else {
        print("Surveyor with ID \(id) not found!")
        exit(0)
    }
    
    print("Are you sure you want to delete this surveyor?")
    printSurveyor(data.surveyors[index])
    print("Type 'confirm' to confirm: ", terminator: "")
    if readLine() == "confirm" {
        data.surveyors.remove(at: index)
        
        if check {
            print("Validating data...")
            let errors = validate(data: data)
            print("Validation complete. \(errors.count) error(s) found.")
            for error in errors {
                print(error)
            }
            
            if errors.count > 0 {
                print("The surveyor is not deleted due to having at least 1 error.")
                return
            }
        }
        
        do {
            try saveFile(data: data)
            print("The surveyor has been successfully deleted!")
        } catch {
            print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
        }
    }
}

func deletePort(index: Int, data: PortsAndSurveyorsData, check: Bool) {
    print("Are you sure you want to delete this port?")
    printPort(data.ports[index])
    print("Type 'confirm' to confirm: ", terminator: "")
    if readLine() == "confirm" {
        data.ports.remove(at: index)
        
        if check {
            print("Validating data...")
            let errors = validate(data: data)
            print("Validation complete. \(errors.count) error(s) found.")
            for error in errors {
                print(error)
            }
            
            if errors.count > 0 {
                print("The port is not deleted due to having at least 1 error.")
                return
            }
        }
        
        do {
            try saveFile(data: data)
            print("The port has been successfully deleted!")
        } catch {
            print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
        }
    }
}

func delete(args: [String], data: PortsAndSurveyorsData) {
    if args.count < 2 {
        print("At least 2 arguments expected for 'delete' command!")
        exit(0)
    }
    switch args[0] {
    case "-s":
        guard let id = Int(args[1]) else {
            print("Invalid Surveyor ID")
            exit(0)
        }
        
        deleteSurveyor(id: id, data: data, check: args.contains("-c"))
    case "-p":
        guard let i = Int(args[1]) else {
            print("Invalid Port Index")
            exit(0)
        }
        guard i < data.ports.count && i >= 0 else {
            print("Port Index Out of Range")
            exit(0)
        }
        deletePort(index: i, data: data, check: args.contains("-c"))
    default:
        print("Unrecognised argument: \(args[0])")
        exit(0)
    }
}
