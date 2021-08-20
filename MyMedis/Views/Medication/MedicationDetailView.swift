//
//  MedicationDetailView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 10.07.21.
//
//

import SwiftUI
import CoreData

struct MedicationDetailView: View {
    var viewContext: NSManagedObjectContext
    var medication: Medication

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Detail")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(
                            destination: EditMedicationView(viewContext: viewContext, medication: medication),
                            label: {
                                Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(1 / 1, contentMode: .fit)
                                        .foregroundColor(Color("red"))
                            })
                    .padding(.trailing)
                    Button(action: deleteMedication) {
                        Image(systemName: "trash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(1 / 1, contentMode: .fit)
                                .foregroundColor(Color("red"))
                    }
                }
                Spacer()
                Text(medication.name ?? "")
                        .font(.largeTitle)
                if medication.substances != "" {
                    Text("Wirkstoff: \(medication.substances ?? "")")
                }
                if medication.authHolder != nil {
                    Text("Zulassungsinhaber: \(medication.authHolder ?? "")")
                }
                Spacer()
            }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .padding()
        }
                .accentColor(Color("red"))
    }

    private func deleteMedication() {
        withAnimation {
            viewContext.delete(medication)
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
