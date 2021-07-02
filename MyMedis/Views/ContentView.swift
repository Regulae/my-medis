//
//  ContentView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selection: Tab = .medicationOverview
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Medication.timeStamp, ascending: true)], animation: .default) private var medications : FetchedResults<Medication>
    
    enum Tab{
        case medicationOverview
        case medicationList
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "red")
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Image("logo_bg_transparent")
                    .resizable()
                    .frame(width: 80)
                    .aspectRatio(1/1, contentMode: .fit)
                Text("My Medis")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: addMedication){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(1/1, contentMode: .fit)
                        .foregroundColor(Color("red"))
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            TabView(selection: $selection){
                MedicationOverview(medications: medications, viewContext: viewContext)
                    .tabItem { Label("Featured", systemImage: "calendar" )}
                    .tag(Tab.medicationOverview)
                SwissmedicMedicationsView(searchText: "")
                    .tabItem { Label("List", systemImage: "list.bullet") }
                    .tag(Tab.medicationList)
            }
            .accentColor(.white)
        }
    }
    
    private func addMedication() {
        withAnimation {
            let newItem = Medication(context: viewContext)
            newItem.name = ""
            newItem.substances=""
            newItem.timeStamp = Date()

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
