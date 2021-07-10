//
//  MedicationOverview.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI
import CoreData

struct MedicationOverview: View {
    @EnvironmentObject var modelData: ModelData
    var medications: FetchedResults<Medication>
    var viewContext: NSManagedObjectContext

    var morningMedications: [Medication] {
        medications.filter { medication in
            medication.daytime == "Morning"
        }
    }
    var lunchMedications: [Medication] {
        medications.filter { medication in
            medication.daytime == "Lunch"
        }
    }
    var eveningMedications: [Medication] {
        medications.filter { medication in
            medication.daytime == "Evening"
        }
    }
    var nightMedications: [Medication] {
        medications.filter { medication in
            medication.daytime == "Night"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Today")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                if morningMedications.count >= 1 {
                    Text("Morning")
                            .font(.title2)
                    ForEach(morningMedications) { medication in
                        MedicationRow(medication: medication)
                    }
                            .onDelete(perform: deleteMedications)
                    Divider()
                }
                if lunchMedications.count >= 1 {
                    Text("Lunch")
                            .font(.title2)

                    ForEach(lunchMedications) { medication in
                        MedicationRow(medication: medication)
                    }
                            .onDelete(perform: deleteMedications)
                    Divider()
                }
                if eveningMedications.count >= 1 {
                    Text("Evening")
                            .font(.title2)
                    ForEach(eveningMedications) { medication in
                        MedicationRow(medication: medication)
                    }
                            .onDelete(perform: deleteMedications)
                    Divider()

                }
                if nightMedications.count >= 1 {
                    Text("Night")
                            .font(.title2)
                    ForEach(nightMedications) { medication in
                        MedicationRow(medication: medication)
                    }
                            .onDelete(perform: deleteMedications)
                    Divider()
                }

                Spacer()
            }
                    .padding(.horizontal)
        }
    }

    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                medications[$0]
            }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()