//
//  Medication+CoreDataClass.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 02.07.21.
//
//

import Foundation
import CoreData

enum Daytime: Int16{
    case morning = 1
    case lunch = 2
    case evening = 3
    case night = 4
}

@objc(Medication)
public class Medication: NSManagedObject {
    @NSManaged var dayTime: Int16
    var dayTimeEnum: Daytime{
        get{ return Daytime(rawValue: self.dayTime) ?? .morning}
        set{ self.dayTime = newValue.rawValue}
    }
}
