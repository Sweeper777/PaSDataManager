import Foundation


let arguments = CommandLine.arguments

if arguments.count == 1 {
    print("Please enter a subcommand")
    exit(0)
}

switch arguments[1].lowercased() {
case "validate":
    let data = readFile()
    validate(data: data)
case "view":
    let data = readFile()
    let subcommandArguments = Array(arguments.dropFirst(2).dropLast())
    view(args: subcommandArguments, data: data)
default:
    print("Unknown command")
    exit(0)
}
