import Foundation

let sampleDataAddress = "https://jsonplaceholder.typicode.com/users"
let url = URL(string: sampleDataAddress)!
let jsonData = try! Data(contentsOf: url)

struct User {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company

    init?(dict: [String: Any]) {
        guard
            let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let username = dict["username"] as? String,
            let email = dict["email"] as? String,
            let phone = dict["phone"] as? String,
            let website = dict["website"] as? String,
            let addressDict = dict["address"] as? [String: Any],
            let address = Address(dict: addressDict),
            let companyDict = dict["company"] as? [String: Any],
            let company = Company(dict: companyDict)
            else {
                return nil
        }

        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }

    struct Address {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Coordinates

        init?(dict: [String: Any]) {
            guard
                let street = dict["street"] as? String,
                let suite = dict["suite"] as? String,
                let city = dict["city"] as? String,
                let zipcode = dict["zipcode"] as? String,
                let geoDict = dict["geo"] as? [String: Any],
                let geo = Coordinates(dict: geoDict) else {
                    return nil
            }

            self.street = street
            self.suite = suite
            self.city = city
            self.zipcode = zipcode
            self.geo = geo
        }

        struct Coordinates {
            let lat: Double
            let lng: Double

            init?(dict: [String: Any]) {
                guard
                    let latString = dict["lat"] as? String,
                    let lat = Double(latString),
                    let lngString = dict["lng"] as? String,
                    let lng = Double(lngString) else {
                        return nil
                }
                self.lat = lat
                self.lng = lng
            }
        }
    }

    struct Company {
        let name: String
        let catchPhrase: String
        let bs: String

        init?(dict: [String: Any]) {
            guard
                let name = dict["name"] as? String,
                let catchPhrase = dict["catchPhrase"] as? String,
                let bs = dict["bs"] as? String else {
                    return nil
            }

            self.name = name
            self.catchPhrase = catchPhrase
            self.bs = bs
        }
    }
}

if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
    if let jsonArray = json as? [[String: Any]] {
        let users = jsonArray.flatMap {
            User(dict: $0)
        }
        users.count
        dump(users.first)
    }
}
