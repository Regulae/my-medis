//
//  ContentView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Image("mymedis_heart_no_text")
                    .resizable()
                    .frame(width: 80)
                    .aspectRatio(1/1, contentMode: .fit)
                Text("My Medis")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(1/1, contentMode: .fit)
                        .foregroundColor(Color("red"))
                }
            }
            .frame(maxWidth: .infinity)
            Text("Today")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            MedicationOverview()
            SwissmedicMedicationsView()
            Spacer()

        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
