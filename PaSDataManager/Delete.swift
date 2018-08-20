import Foundation

func deleteSurveyor(id: Int, data: PortsAndSurveyorsData) {
    
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
