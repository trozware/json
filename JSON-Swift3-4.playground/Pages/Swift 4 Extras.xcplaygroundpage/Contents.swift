import Foundation

let jsonString = """
{
"name1": "Jane",
"name2": "Smith"
}
"""
let jsonData = jsonString.data(using: .utf8)!

struct Person: Codable {
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "name1"
        case lastName = "name2"
    }
}

let jsonDecoder = JSONDecoder()
let person = try? jsonDecoder.decode(Person.self, from: jsonData)
dump(person)


let jsonString2 = """
{
"name": "My New Project",
"created": "2017-06-18T06:28:25Z"
}
"""
let jsonData2 = jsonString2.data(using: .utf8)!

struct Project: Codable {
    let name: String
    let created: Date
}

let jsonDecoder2 = JSONDecoder()
jsonDecoder2.dateDecodingStrategy = .iso8601
let project = try? jsonDecoder2.decode(Project.self, from: jsonData2)

dump(project)


let jsonEncoder = JSONEncoder()
jsonEncoder.dateEncodingStrategy = .iso8601

if let backToJson = try? jsonEncoder.encode(project) {
    if let jsonString = String(data: backToJson, encoding: .utf8) {
        print(jsonString)
    }
}

let plistEncoder = PropertyListEncoder()
plistEncoder.outputFormat = .xml
if let plist = try? plistEncoder.encode(project) {
    if let plistString = String(data: plist, encoding: .utf8) {
        print(plistString)
    }

    let plistDecoder = PropertyListDecoder()
    let project2 = try? plistDecoder.decode(Project.self, from: plist)

    dump(project2)
}

