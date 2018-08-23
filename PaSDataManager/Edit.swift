import Foundation

func editSurveyor(id: Int, data: PortsAndSurveyorsData) {
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
    }
}
