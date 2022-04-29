//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ifang Lee on 4/29/22.
//

import SwiftUI

class Favorites: ObservableObject, Codable {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let savedResortsIds = UserDefaults.standard.object(forKey: saveKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedResortsIds = try? decoder.decode(Set<String>.self, from: savedResortsIds) {
                resorts = loadedResortsIds
                return
            }
        }

        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(resorts) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: saveKey)
        }
    }
}
