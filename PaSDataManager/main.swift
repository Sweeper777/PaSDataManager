import Foundation

let arguments = CommandLine.arguments

if arguments.count == 1 {
    print("Please enter a subcommand")
    exit(0)
}

