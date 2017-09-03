import Foundation

// Changing Property Names

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


// Date Handling

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


// Allowing For Nulls

struct Role: Codable {
    let firstName: String
    let lastName: String
    let nickName: String?
}

let jsonStringWithNulls = """
[
{
"firstName": "Sally",
"lastName": "Sparrow",
"nickName": null
},
{
"firstName": "Doctor",
"lastName": "Who",
"nickName": "The Doctor"
}
]
"""
let jsonDataWithNulls = jsonStringWithNulls.data(using: .utf8)!

let jsonDecoder3 = JSONDecoder()
let roles = try? jsonDecoder3.decode(Array<Role>.self, from: jsonDataWithNulls)
dump(roles)

let jsonEncoder2 = JSONEncoder()
jsonEncoder2.outputFormatting = .prettyPrinted

if let backToJsonWithNulls = try? jsonEncoder2.encode(roles) {
    if let jsonString = String(data: backToJsonWithNulls, encoding: .utf8) {
        print(jsonString)
    }
}

// Property Lists

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
