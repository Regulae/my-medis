//
//  AddMedicationView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 02.07.21.
//

import SwiftUI
import CoreData

extension Date {
    static var tomorrow: Date {
        return Date().dayAfter
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

struct AddMedicationView: View {
    @State var medicationName: String = ""
    @State var substances: String = ""
    @State var daytime: String = "Morning"
    @State private var showingSearch = false

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Medication Name:")
                    HStack {
                        TextField("Medication Name", text: $medicationName)
                        Button(action: { showingSearch = true }) {
                            Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .aspectRatio(1 / 1, contentMode: .fit)
                                    .foregroundColor(Color("red"))
                        }
                    }
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
                    Button(action: addMedication) {
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
                    .navigationBarTitle("Add Medication")
                    .sheet(isPresented: $showingSearch) {
                        SwissmedicMedicationsView(searchText: "", showSearch: $showingSearch, medicationName: $medicationName, medicationSubstances: $substances)
                    }
        }
                .accentColor(Color("red"))
    }

    private func addMedication() {
        withAnimation {
            let now = Date()
            let newItem = Medication(context: viewContext)
            newItem.name = medicationName
            newItem.substances = substances
            newItem.timeStamp = now
            newItem.daytime = daytime
            newItem.takeNext = Date.tomorrow
            newItem.taken = false
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

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView()
    }
}
