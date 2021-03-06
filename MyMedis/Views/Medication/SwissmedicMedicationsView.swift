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
    @Binding var showSearch: Bool
    @Binding var medicationName: String
    @Binding var medicationSubstances: String
    @Binding var medicationAuthHolder: String

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                    .padding(.top, 30)
            List(modelData.swissmedicMedications.filter({ searchText.isEmpty ? true : ($0.name.contains(searchText) || ($0.substances ?? "").contains(searchText)) })) { item in
                Button(action: {
                    self.medicationName = item.name
                    self.medicationSubstances = item.substances ?? ""
                    self.medicationAuthHolder = item.authHolder
                    self.showSearch = false
                }) {
                    Text(item.name)
                }
            }
        }
                .padding(.horizontal)
    }
}
