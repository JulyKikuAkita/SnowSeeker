//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/27/22.
//

import SwiftUI

/*
 SizeClass:
 All iPhones in portrait have compact width and regular height.
 Most iPhones in landscape have compact width and compact height.
 Large iPhones (Plus-sized and Max devices) in landscape have regular width and compact height.
 All iPads in both orientations have regular width and regular height when your app is running with the full screen.

 // if need to limit dynamic type size, using .dynamicTypeSize(...DynamicTypeSize.xxxLarge) make xxxLarge the upper bound
 */
struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?
    @State private var showingFaclity = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()

                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFaclity = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFaclity, presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
        }

        Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
            if favorites.contains(resort) {
                favorites.remove(resort)
            } else {
                favorites.add(resort)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort:  Resort.example)
            .previewInterfaceOrientation(.portrait)
            .environmentObject(Favorites())
    }
}
