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
    var id = "Taylor Swift"
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass  // “compact” and “regular”
    @State private var layoutVertically = false

    var body: some View {
        VStack {
            Group {
                if layoutVertically {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            .onTapGesture {
                layoutVertically.toggle()
            }

            Text("Use SizeClass:")
                .padding()


            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }

            // syntax sugar
            // where you have only one view inside a stack and it doesn’t take any parameters, you can pass the view’s initializer directly to the VStack to make your code shorter
//            if sizeClass == .compact {
//                VStack(content: UserView.init)
//            } else {
//                HStack(content: UserView.init)
//            }
        }
    }
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
