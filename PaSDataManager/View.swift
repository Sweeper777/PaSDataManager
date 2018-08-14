import Foundation

func printSurveyor(_ surveyor: Surveyor) {
    print("Name: \(surveyor.name)")
    print("ID: \(surveyor.id)")
    print("Contacts:")
    for line in surveyor.contacts {
        print(line)
    }
    print("Prices:")
    for line in surveyor.prices {
        print(line)
    }
}
