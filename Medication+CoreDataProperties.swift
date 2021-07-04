//
//  Medication+CoreDataProperties.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 02.07.21.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var takeNext: Date?
    @NSManaged public var name: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var substances: String?
    @NSManaged public var daytime: String?

}

extension Medication : Identifiable {

}
