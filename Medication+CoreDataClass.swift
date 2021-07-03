//
//  Medication+CoreDataClass.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 02.07.21.
//
//

import Foundation
import CoreData

enum Daytime: String, Equatable, CaseIterable{
    case morning = "Morning"
    case lunch = "Lunch"
    case evening = "Evening"
    case night = "Night"
    
    var id: String {self.rawValue}
}

@objc(Medication)
public class Medication: NSManagedObject {
    @NSManaged var dayTime: String
    var dayTimeEnum: Daytime{
        get{ return Daytime(rawValue: self.dayTime) ?? .morning}
        set{ self.dayTime = newValue.rawValue}
    }
}
