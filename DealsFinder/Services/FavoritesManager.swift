//
//  FavoritesManager.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import Foundation

class FavoritesManager {

    static let shared = FavoritesManager()

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "savedFavorites"

    private init() {}

    // MARK: - Favorites Management

    func saveFavorite(_ deal: Deal) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == deal.id }) {
            favorites.append(deal)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(_ dealId: String) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == dealId }
        saveFavorites(favorites)
    }

    func isFavorite(_ dealId: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.id == dealId }
    }

    func getFavorites() -> [Deal] {
        guard let data = userDefaults.data(forKey: favoritesKey) else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Deal].self, from: data)
            return favorites
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
    }

    func toggleFavorite(_ deal: Deal) -> Bool {
        if isFavorite(deal.id) {
            removeFavorite(deal.id)
            return false
        } else {
            saveFavorite(deal)
            return true
        }
    }

    // MARK: - Private Methods

    private func saveFavorites(_ favorites: [Deal]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }

    func clearAllFavorites() {
        userDefaults.removeObject(forKey: favoritesKey)
    }
}
