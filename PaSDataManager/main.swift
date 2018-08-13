import Foundation

let arguments = CommandLine.arguments

if arguments.count == 1 {
    print("Please enter a subcommand")
    exit(0)
}

switch arguments[1] {
case "validate":
    guard let jsonString = try? String(contentsOfFile: arguments.last!) else {
        print("File not found")
        exit(0)
    }
    guard let portsAndSurveyorsData = try? JSONDecoder().decode(PortsAndSurveyorsData.self, from: jsonString.data(using: .utf8)!) else {
        print("JSON not in correct format!")
        exit(0)
    }
    validate(data: portsAndSurveyorsData)
default:
    print("Unknown command")
    exit(0)
}
