//
//  WidgetView.swift
//  MedicationWidgetExtension
//
//  Created by Regula Susan Heisch on 04.07.21.
//


import SwiftUI
import CoreData

struct WidgetView: View {

    var body: some View {
        VStack {
            Text("Today")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(meds) { medication in
                Text("\(medication.name!)")
                        .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }

    var meds: [Medication] {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        do {
            return try CoreDataStack.shared.managedObjectContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
