//
//  AddMedicationView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 02.07.21.
//

import SwiftUI
import CoreData

struct AddMedicationView: View {
    @State var medicationName: String = ""
    @State var substances: String = ""
    @State var authHolder: String = ""
    @State var daytime: String = "Morning"
    @State private var showingSearch = false

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                Text("Medikamentenname:")
                HStack {
                    TextField("Medikamentenname", text: $medicationName)
                    Button(action: { showingSearch = true }) {
                        Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .aspectRatio(1 / 1, contentMode: .fit)
                                .foregroundColor(Color("red"))
                    }
                }
                Text("Wirkstoff")
                TextField("Wirkstoff", text: $substances)
                Picker("Einnahmezeit", selection: $daytime) {
                    Text("Morgen").tag("Morning")
                    Text("Mittag").tag("Lunch")
                    Text("Abend").tag("Evening")
                    Text("Nacht").tag("Night")
                }

            }
            HStack(alignment: .center) {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Text("Abbrechen")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: addMedication) {
                    Text("Speichern")
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
                .navigationBarTitle("Hinzufügen")
                .sheet(isPresented: $showingSearch) {
                    SwissmedicMedicationsView(searchText: "", showSearch: $showingSearch, medicationName: $medicationName, medicationSubstances: $substances, medicationAuthHolder: $authHolder)
                }
    }

    private func addMedication() {
        withAnimation {
            let now = Date()
            let newItem = Medication(context: viewContext)
            newItem.name = medicationName
            newItem.substances = substances
            newItem.timeStamp = now
            newItem.daytime = daytime
            newItem.taken = false
            newItem.authHolder = authHolder
            do {
                try viewContext.save()
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
