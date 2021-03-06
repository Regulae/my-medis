//
//  EditUserView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 01.08.21.
//
//

import SwiftUI

struct EditUserView: View {

    var userData: UserData

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var gender: String = ""
    @State var age: String = ""
    @State var language: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                Text("Vorname")
                TextField("Vorname", text: $firstName)
                Text("Nachname")
                TextField("Nachname", text: $lastName)
                Picker("Geschlecht", selection: $gender) {
                    Text("Männlich").tag("Male")
                    Text("Weiblich").tag("Female")
                }
                Text("Alter")
                TextField("Alter", text: $age)
                        .keyboardType(.numberPad)
                Picker("Sprache", selection: $language) {
                    Text("Deutsch").tag("Deutsch")
                    Text("Français").tag("Français")
                    Text("Italiano").tag("Italiano")
                    Text("English").tag("English")
                }
            }
            HStack(alignment: .center) {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Text("Abbrechen")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: editUser) {
                    Text("Speichern")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color("red"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            }
                    .padding(.bottom)
        }
                .onAppear(perform: fill)
                .navigationBarTitle("Bearbeiten")
    }

    private func fill() {
        firstName = firstName != "" ? firstName : userData.firstName
        lastName = lastName != "" ? lastName : userData.lastName
        gender = gender != "" ? gender : (userData.gender == "" ? "Male" : userData.gender)
        age = age != "" ? age : userData.age
        language = language != "" ? language : (userData.language == "" ? "Deutsch" : userData.language)
    }

    private func editUser() {
        self.userData.edit(firstName: firstName, lastName: lastName, gender: gender, age: age, language: language)
        self.presentationMode.wrappedValue.dismiss()
    }
}

