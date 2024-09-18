//
//  FavoritesManager.swift
//  HackIllinoisEvent
//
//  Created by Yash Jagtap on 9/17/24.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favoriteEvents"
    
    private init() {}
    
    func isFavorite(eventId: String) -> Bool {
        let favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        return favorites.contains(eventId)
    }
    
    func addFavorite(eventId: String) {
        var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        if !favorites.contains(eventId) {
            favorites.append(eventId)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
    
    func removeFavorite(eventId: String) {
        var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        if let index = favorites.firstIndex(of: eventId) {
            favorites.remove(at: index)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
}

