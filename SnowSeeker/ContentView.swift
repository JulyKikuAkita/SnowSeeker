//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/23/22.
//

import SwiftUI

/*
 SwiftUI has two ways of creating alerts and sheets, 1. a binding to a Boolean that shows the alert or sheet when the Boolean becomes true. 2. The second option allows us to bind an optional to the alert or sheet
 */

struct User: Identifiable {
    var id = UUID().uuidString
}

struct ContentView: View {
    @State private var selecedUser1: User? = nil
    @State private var selecedUser2: User? = nil
    @State private var isShowingUser = false
    @State private var isShowingUser3 = false
    @State private var isShowingUser4 = false

    var body: some View {
        VStack {
            Text("Binding sheet using optional")
                .padding()
                .onTapGesture {
                    selecedUser1 = User()
                }
                .sheet(item: $selecedUser1) { user in
                    Text(user.id)
                }

            Text("Binding sheet using boolean")
                .padding()
                .onTapGesture {
                    selecedUser2 = User() // 2nd tap user got initiated
                    isShowingUser = true
                }
                .sheet(isPresented: $isShowingUser) {
                    Text(selecedUser2?.id ?? "User is null")
                }

            Text("Binding Alerts")
                .padding()
                .onTapGesture {
                    selecedUser1 = User()
                    isShowingUser3 = true
                }
                .alert("Button with user id", isPresented: $isShowingUser3, presenting: selecedUser1) { user in
                    Button(user.id) { }
                }

            Text("Binding Alerts with OK button")
                .padding()
                .onTapGesture {
                    isShowingUser4 = true
                }
                .alert("Ok Button", isPresented: $isShowingUser4) {
                    Button("OK") {}
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
