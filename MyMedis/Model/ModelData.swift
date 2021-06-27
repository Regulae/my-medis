//
//  ModelData.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 26.06.21.
//

import Foundation

final class ModelData: ObservableObject{
    var swissmedicMedications: [SwissmedicMedication] = load("swissmedicMedications.json")
    var testMedis: [Medication] = load("testMedis.json")
    
    var medications: [String: [Medication]]{
        Dictionary(
            grouping: testMedis, by: {$0.daytime.rawValue})
    }
    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
