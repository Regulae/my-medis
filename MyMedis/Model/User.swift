//
//  User.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 11.07.21.
//
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var gender: Gender
    var age: Int16
    var language: Language

    static let `default` = User(firstName: "Max", lastName: "Muster", gender: Gender.m, age:30, language: Language.de)

    enum Gender: String, CaseIterable, Identifiable {
        case m = "Male"
        case f = "Female"

        var id: String {
            self.rawValue
        }
    }

    enum Language: String, CaseIterable, Identifiable {
        case en = "English"
        case de = "Deutsch"
        case fr = "Français"
        case it = "Italiano"

        var id: String {
            self.rawValue
        }
    }
}