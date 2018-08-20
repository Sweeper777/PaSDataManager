import Foundation

func deleteSurveyor(id: Int, data: PortsAndSurveyorsData) {
    guard let index = data.surveyors.index(where: { $0.id == id }) else {
        print("Surveyor with ID \(id) not found!")
        exit(0)
    }
    
    print("Are you sure you want to delete this surveyor? (ID \(id)")
    print("Type 'confirm' to confirm: ", terminator: "")
    if readLine() == "confirm" {
        data.surveyors.remove(at: index)
        do {
            try saveFile(data: data)
        } catch {
            print(ANSIColors.red.rawValue + error.localizedDescription + ANSIColors.reset.rawValue)
        }
    }
}

func deletePort(index: Int, data: PortsAndSurveyorsData) {
    print("Are you sure you want to delete this port?")
    print("Type 'confirm' to confirm: ", terminator: "")
    if readLine() == "confirm" {
        data.ports.remove(at: index)
        do {
            try saveFile(data: data)
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
        
        deleteSurveyor(id: id, data: data)
    default:
        print("Unrecognised argument: \(args[0])")
        exit(0)
    }
}
