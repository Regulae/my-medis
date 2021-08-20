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
        NavigationView {
            VStack {
                HStack {
                    Image("logo_bg_transparent")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .aspectRatio(1 / 1, contentMode: .fit)
                    Text("My Medis")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(
                            destination: AddMedicationView(),
                            label: {
                                Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(1 / 1, contentMode: .fit)
                                        .foregroundColor(Color("red"))
                            })
                }
                        .padding()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Heute")
                                .font(.title)
                                .bold()
                                .padding(.bottom)
                        if morningMedications.count >= 1 {
                            Text("Morgen")
                                    .font(.title2)
                            ForEach(morningMedications) { medication in
                                MedicationRow(viewContext: viewContext, medication: medication)
                            }
                            Divider()
                        }
                        if lunchMedications.count >= 1 {
                            Text("Mittag")
                                    .font(.title2)

                            ForEach(lunchMedications) { medication in
                                MedicationRow(viewContext: viewContext, medication: medication)
                            }
                            Divider()
                        }
                        if eveningMedications.count >= 1 {
                            Text("Abend")
                                    .font(.title2)
                            ForEach(eveningMedications) { medication in
                                MedicationRow(viewContext: viewContext, medication: medication)
                            }
                            Divider()

                        }
                        if nightMedications.count >= 1 {
                            Text("Nacht")
                                    .font(.title2)
                            ForEach(nightMedications) { medication in
                                MedicationRow(viewContext: viewContext, medication: medication)
                            }
                            Divider()
                        }

                        Spacer()
                    }
                            .padding(.horizontal)
                }
            }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
        }
                .accentColor(Color("red"))
    }
}

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
