import Foundation

struct User {
    let name: String
    let id: String = UUID().uuidString

    init(name: String) {
        self.name = name
    }
}
