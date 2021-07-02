//
//  Medication.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 27.06.21.
//

import Foundation

struct JsonMedication: Decodable, Hashable, Identifiable{
    var id: Int
    var name: String
    var substances: String?
    var authHolder: String?
    var quantity: Int?
    var unit: Unit?
    var repeating: Repeat = Repeat.never
    var every: Int?
    var frequency: Frequency?
    var daytime: Daytime
    var lastTaken: Date? = Date.init()
    
    
    enum Unit: String, CaseIterable, Decodable{
        case pill = "Pill"
        case capsule = "Capsule"
        case tablet = "Tablet"
        case drop = "Drop"
        case teaspoon = "Teaspoon"
        case tablespoon = "Tablespoon"
        case syringe = "Syringe"
        
        var id: String {self.rawValue}
        
    }
    
    enum Repeat: String, CaseIterable, Decodable{
        case never = "Never"
        case daily = "Daily"
        case weekly = "Weekly"
        case fortnightly = "Fortnightly"
        case monthly = "Monthly"
        case custom = "Custom"
        
        var id: String {self.rawValue}
    }
    
    enum Frequency: String, CaseIterable, Decodable{
        case day = "Day(s)"
        case week = "Week(s)"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        
        var id: String {self.rawValue}
    }
    
    enum Daytime: String, CaseIterable, Decodable{
        case morning = "Morning"
        case lunch = "Lunch"
        case evening = "Evening"
        case night = "Night"
        
        var id: String {self.rawValue}
    }
    
}
