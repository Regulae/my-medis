//
//  UserView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 11.07.21.
//
//

import SwiftUI
import Combine

class UserData: ObservableObject {

    @Published var objectWillChange = PassthroughSubject<Void, Never>()

    var firstName: String
    var lastName: String
    var gender: String
    var age: String
    var language: String

    init(){
        firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
        gender = UserDefaults.standard.string(forKey: "gender") ?? ""
        age = UserDefaults.standard.string(forKey: "age") ?? ""
        language = UserDefaults.standard.string(forKey: "language") ?? ""
    }

    func edit(firstName: String, lastName: String, gender: String, age: String, language: String){
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
        self.language = language
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(language, forKey: "language")
        objectWillChange.send()
    }

}

struct UserView: View {

    @ObservedObject var userData = UserData()

    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("Benutzer")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(
                            destination: EditUserView(userData: userData),
                            label: {
                                Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(1 / 1, contentMode: .fit)
                                        .foregroundColor(Color("red"))
                            })
                }
                Spacer()
                Text("Vorname: \(userData.firstName)")
                Text("Nachname: \(userData.lastName)")
                Text("Geschlecht: \(userData.gender == "Male" ? "♂" : "♀")")
                Text("Alter: \(userData.age)")
                Text("Sprache: \(userData.language)")
                Spacer()
            }.font(.title3)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
        }
                .accentColor(Color("red"))
                .padding()
    }
}
