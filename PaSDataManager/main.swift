import Foundation


let arguments = CommandLine.arguments

if arguments.count == 1 {
    print("Please enter a subcommand")
    exit(0)
}

let data = readFile()
let subcommandArguments = Array(arguments.dropFirst(2).dropLast())
switch arguments[1].lowercased() {
case "validate":
    let errors = validate(data: data)
    print("Validation completed. \(errors.count) error(s) found.")
    for error in errors {
        print(error)
    }
case "view":
    view(args: subcommandArguments, data: data)
case "add":
    add(args: subcommandArguments, data: data)
case "delete":
    delete(args: subcommandArguments, data: data)
case "copy":
    copyDataToClipboard(data: data)
default:
    print("Unknown command")
    exit(0)
}
