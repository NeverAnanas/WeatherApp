import Foundation

protocol Storage {
    associatedtype Item
    
    func get() -> Item
    func set(_ item: Item)
}

struct SaveCity {
    let name: String
    let coordinates: Coordinates
}

struct Coordinates {
    let lat: Float
    let lon: Float
}
