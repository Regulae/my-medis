//
//  WidgetView.swift
//  MedicationWidgetExtension
//
//  Created by Regula Susan Heisch on 04.07.21.
//


import SwiftUI
import CoreData

struct WidgetView: View {

    var meds: [Medication] {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        do {
            return try CoreDataStack.shared.managedObjectContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    var morningMedications: [Medication] {
        meds.filter { medication in
            medication.daytime == "Morning"
        }
    }
    var lunchMedications: [Medication] {
        meds.filter { medication in
            medication.daytime == "Lunch"
        }
    }
    var eveningMedications: [Medication] {
        meds.filter { medication in
            medication.daytime == "Evening"
        }
    }
    var nightMedications: [Medication] {
        meds.filter { medication in
            medication.daytime == "Night"
        }
    }

    var body: some View {
        VStack {
            Text("Today")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            if morningMedications.count >= 1 {
                Text("Morgen")
                        .bold()
                ForEach(morningMedications) { medication in
                    Text("\(medication.name!)")
                }
                Divider()
            }
            if lunchMedications.count >= 1 {
                Text("Mittag")
                        .bold()
                ForEach(lunchMedications) { medication in
                    Text("\(medication.name!)")
                }
                Divider()
            }
            if eveningMedications.count >= 1 {
                Text("Abend")
                        .bold()
                ForEach(eveningMedications) { medication in
                    Text("\(medication.name!)")
                }
                Divider()

            }
            if nightMedications.count >= 1 {
                Text("Nacht")
                        .bold()
                ForEach(nightMedications) { medication in
                    Text("\(medication.name!)")
                }
                Divider()
            }

        }
        .padding()
    }
}
