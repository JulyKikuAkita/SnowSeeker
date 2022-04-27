//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var body: some View {
        NavigationView {
            // need to make sure your view is inside a NavigationView, otherwise iOS won’t have anywhere to put the search box
            // iOS will automatically hide the search bar at the very top of the list – you’ll need to pull down gently to reveal it
            List(filteredNames, id: \.self) { name in
                Text("\(name)")

            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationBarTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter {$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
