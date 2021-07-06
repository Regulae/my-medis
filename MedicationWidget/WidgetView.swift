//
//  WidgetView.swift
//  MedicationWidgetExtension
//
//  Created by Regula Susan Heisch on 04.07.21.
//

import WidgetKit
import SwiftUI
import CoreData

struct WidgetView: View {
    let persistenceController = PersistenceController.shared
    
    var meds: [Medication]{
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        do{
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(meds) { medication in
                    Text("Medication \(medication.name!): \(medication.substances!)")
                }
            }
            Text("Test")
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
