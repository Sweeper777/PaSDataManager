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
