//
//  UserView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 11.07.21.
//
//

import SwiftUI

struct UserView: View {
    @State var firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State var gender = UserDefaults.standard.string(forKey: "gender") ?? ""
    @State var age = UserDefaults.standard.string(forKey: "age") ?? ""
    @State var language = UserDefaults.standard.string(forKey: "language") ?? ""

    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("User")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(
                            destination: EditUserView(),
                            label: {
                                Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(1 / 1, contentMode: .fit)
                                        .foregroundColor(Color("red"))
                            })
                }
                Spacer()
                Text("First Name: \(firstName)")
                Text("Last Name: \(lastName)")
                Text("Gender: \(gender == "Male" ? "♂" : "♀")")
                Text("Age: \(age)")
                Text("Language: \(language)")
                Spacer()
            }.font(.title3)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
        }
                .accentColor(Color("red"))
                .padding()
    }
}
