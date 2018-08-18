import Foundation

enum ANSIColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case reset = "\u{001B}[0;0m"
    
    func name() -> String {
        switch self {
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        case .reset: return "Reset"
        }
    }
    
    static func all() -> [ANSIColors] {
        return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
    }
}

func printSeparator(withColor color: ANSIColors = .reset) {
    print(color.rawValue + "--------------------------------" + ANSIColors.reset.rawValue)
}

func readFile() -> PortsAndSurveyorsData {
    guard let jsonString = try? String(contentsOfFile: arguments.last!) else {
        print("File not found")
        exit(0)
    }
    guard let portsAndSurveyorsData = try? JSONDecoder().decode(PortsAndSurveyorsData.self, from: jsonString.data(using: .utf8)!) else {
        print("JSON not in correct format!")
        exit(0)
    }
    return portsAndSurveyorsData
}

func saveFile(data: PortsAndSurveyorsData) throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(data)
    let jsonString = String(data: data, encoding: .utf8)!
    try jsonString.write(to: URL(string: CommandLine.arguments.last!)!, atomically: false, encoding: .utf8)
}
