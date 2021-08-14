//
//  EditMedicationView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 13.08.21.
//
//

import SwiftUI
import CoreData

struct EditMedicationView: View {
    var viewContext: NSManagedObjectContext
    var medication: Medication

    @State var medicationName: String = ""
    @State var substances: String = ""
    @State var daytime: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                Text("Medication Name:")
                TextField("Medication Name", text: $medicationName)
                Text("Substances")
                TextField("Substances", text: $substances)
                Picker("Day Time", selection: $daytime) {
                    Text("Morning").tag("Morning")
                    Text("Lunch").tag("Lunch")
                    Text("Evening").tag("Evening")
                    Text("Night").tag("Night")
                }

            }
            HStack(alignment: .center) {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Text("Cancel")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: editMedication) {
                    Text("Save")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color("red"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            }
                    .padding(.bottom)
        }
                .onAppear(perform: fill)
                .navigationBarTitle("Edit Medication")
    }

    private func fill() {
        medicationName = medicationName != "" ? medicationName : (medication.name ?? "")
        substances = substances != "" ? substances : (medication.substances ?? "")
        daytime = daytime != "" ? daytime: (medication.daytime == "" ? "Morning" : (medication.daytime ?? ""))
    }

    private func editMedication() {
        withAnimation {
            medication.name = medicationName
            medication.substances = substances
            medication.daytime = daytime
            do{
                try viewContext.save()
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
