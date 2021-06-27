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
            Text("Today")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Morning")
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Lunch")
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Evening")
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Night")
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MedicationOverview_Previews: PreviewProvider {
    static var previews: some View {
        MedicationOverview()
    }
}
