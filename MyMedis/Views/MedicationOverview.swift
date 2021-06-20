//
//  MedicationOverview.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI

struct MedicationOverview: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Morgen")
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct MedicationOverview_Previews: PreviewProvider {
    static var previews: some View {
        MedicationOverview()
    }
}
