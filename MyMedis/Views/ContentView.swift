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
        NavigationView{
            VStack{
                
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
            .navigationTitle("")
            .navigationBarItems(leading:
                                    HStack{
                                        Image("logo_bg_transparent")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .aspectRatio(1/1, contentMode: .fit)
                                        Text("My Medis")
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(.vertical)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    },
                                trailing: NavigationLink(
                                    destination: AddMedicationView(),
                                    label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .aspectRatio(1/1, contentMode: .fit)
                                            .foregroundColor(Color("red"))
                                    })
                                
                                
            )
            
        }
        .accentColor(Color("red"))
        .padding(.top, 0.0)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}




