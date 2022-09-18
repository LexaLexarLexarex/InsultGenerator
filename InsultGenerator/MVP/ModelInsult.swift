// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let insult = try? newJSONDecoder().decode(Insult.self, from: jsonData)

import Foundation

struct Insult: Codable {
    let number, language, insult, created: String
    let shown, createdby, active: String
    let comment: String
}
