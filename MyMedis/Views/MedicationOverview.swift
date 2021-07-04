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
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Today")
                .font(.title)
                .bold()
            List{
                ForEach(medications) { medication in
                    MedicationRow(medication: medication)
                }
                .onDelete(perform: deleteMedications)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            offsets.map { medications[$0] }.forEach(viewContext.delete)

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

//struct MedicationOverview_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//    }
//}
