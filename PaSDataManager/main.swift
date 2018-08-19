import Foundation


let arguments = CommandLine.arguments

if arguments.count == 1 {
    print("Please enter a subcommand")
    exit(0)
}

switch arguments[1].lowercased() {
case "validate":
    let data = readFile()
    let errors = validate(data: data)
    print("Validation completed. \(errors.count) error(s) found.")
    for error in errors {
        print(error)
    }
case "view":
    let data = readFile()
    let subcommandArguments = Array(arguments.dropFirst(2).dropLast())
    view(args: subcommandArguments, data: data)
case "add":
    let data = readFile()
    let subcommandArguments = Array(arguments.dropFirst(2).dropLast())
    add(args: subcommandArguments, data: data)
default:
    print("Unknown command")
    exit(0)
}
