//
//  MedicationRow.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 27.06.21.
//

import SwiftUI

struct MedicationRow: View {
    @State private var showDetail = false

    let userCalendar = Calendar.current
    let now = Date()
    let medication: Medication
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack {
            Button(action: { showDetail = true }) {
                Text(medication.name!)
                        .foregroundColor(Color("textColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
            }
            if (!medication.taken) {
                Button(action: setMedicationTaken) {
                    Image(systemName: "circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(1 / 1, contentMode: .fit)
                            .foregroundColor(Color("textColor"))
                }
            } else if (medication.taken) {
                Button(action: unsetMedicationTaken) {
                    Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(1 / 1, contentMode: .fit)
                            .foregroundColor(Color("green"))
                }
            }

        }
                .onAppear(perform: checkLastTaken)
                .sheet(isPresented: $showDetail) {
                    MedicationDetailView(medication: medication)
                }
    }

    private func checkLastTaken() {
        let daysFromTaken = Calendar.current.isDate(medication.lastTaken ?? Date(), equalTo: now, toGranularity: .day)
        if !daysFromTaken {
            medication.taken = false
        }
    }

    private func setMedicationTaken() {
        withAnimation {
            medication.taken = true
            medication.lastTaken = now
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

    private func unsetMedicationTaken() {
        withAnimation {
            medication.taken = false
            medication.lastTaken = medication.timeStamp
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
