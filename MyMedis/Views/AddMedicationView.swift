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
    @State var daytime: Daytime = .morning
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView{
            VStack{
            Form{
                TextField("Medication Name", text: $medicationName)
                TextField("Substances", text: $substances)
//                Picker("Day Time", selection: $daytime){
//                    ForEach(Daytime.allCases, id: \.id){ value in
//                        Text(value.rawValue).tag(value)
//                    }
//                }

            }
                HStack(alignment: .center){
                    Button(action: {}){
                        Text("Cancel")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                    }
                    .background(Color(.gray))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Button(action: addMedication){
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
        }
    }
    
    private func addMedication() {
        withAnimation {
            let newItem = Medication(context: viewContext)
            newItem.name = medicationName
            newItem.substances = substances
            newItem.timeStamp = Date()
//            newItem.dayTimeEnum = daytime

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

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView()
    }
}
