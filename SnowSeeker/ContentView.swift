//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/23/22.
//

import SwiftUI

/*
 Challenge:
 1. Add a photo credit over the ResortView image. The data is already loaded from the JSON for this purpose, so you just need to make it look good in the UI.
 2. Fill in the loading and saving methods for Favorites.
 3. For a real challenge, let the user sort the resorts in ContentView either using the default order, alphabetical order, or country order.
 */
struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}
enum OrderBy: String, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }
    case id, name, country, elevation, runs}
struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    @State private var searchText = ""
    @State private var sortOrder: OrderBy = .id
    @StateObject var favorites = Favorites()
    var body: some View {
        NavigationView {
            VStack {
                Section("Sorted by") {
                    Picker("", selection: $sortOrder) {
                        ForEach(OrderBy.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                }
                List(sortedResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }

                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
//            .phoneOnlyStackNavigationView() //enabel to force iphone13 max to use stack navigation style

            WelcomeView()

        }
        .environmentObject(favorites)
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter{ $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var sortedResorts: [Resort] {
        switch sortOrder {
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted{ $0.country < $1.country }
        case .elevation:
            return filteredResorts.sorted{ $0.elevation < $1.elevation }
        case .runs:
            return filteredResorts.sorted{ $0.runs < $1.runs }
        default:
            return filteredResorts.sorted { $0.id < $1.id }
        }
    }
}

// Stop iPhones from using the slide over approach, try on iPhone 13 max / ipad
// Need to use the @ViewBuilder attribute here because the two returned view types are different.
extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
