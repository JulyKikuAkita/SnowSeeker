//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/23/22.
//

import SwiftUI

/*
 SwiftUI restrains:
 Detail views always get a navigation bar whether you want it or not, so you need to use navigationBarHidden(true) to hide it.
 There’s no way of making the primary view stay visible even when there is more than enough space.
 You can’t make the primary view shown in landscape by default; SwiftUI always chooses the detail.

 */
struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New Secondary")
            } label: {
                Text("Hello World")
            }
            .navigationTitle("Primary")

            NavigationLink {
                Text("New Third")
            } label: {
                Text("Hello World Secondary")
            }
            .navigationTitle("Secondary")

            Text("Third View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
