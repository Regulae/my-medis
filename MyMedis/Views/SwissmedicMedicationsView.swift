//
//  SwissmedicMedicationsView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 26.06.21.
//

import SwiftUI

struct SwissmedicMedicationsView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var searchText: String
    
    var filteredMedications: [SwissmedicMedication]{
        modelData.swissmedicMedications.filter{ medication in
            (medication.substances != nil)
        }
    }
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.top, 30)
            List(filteredMedications.filter({searchText.isEmpty ? true : ($0.name.contains(searchText) || $0.substances!.contains(searchText))})){ item in
                Text(item.name)
            }
//            List{
//                ForEach(filteredMedications){ medication in
//                    Text(medication.name)
//                }
//            }
        }
    }
}

struct SwissmedicMedicationsView_Previews: PreviewProvider {
    static var previews: some View {
        SwissmedicMedicationsView(searchText: "Ibuprofen")
            .environmentObject(ModelData())
    }
}
