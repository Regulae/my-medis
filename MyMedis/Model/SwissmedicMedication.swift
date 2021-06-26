//
//  SwissmedicMedication.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 26.06.21.
//

import Foundation

struct SwissmedicMedication: Codable, Hashable, Identifiable{
    var id: Int
    var name: String
    var substances: String? = ""
    var authHolder: String
}
