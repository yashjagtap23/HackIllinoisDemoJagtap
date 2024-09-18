//
//  Event.swift
//  HackIllinoisEvent
//
//  Created by Yash Jagtap on 9/17/24.
//

import Foundation

struct Event: Identifiable, Codable {
    let eventId: String
    let name: String
    let description: String
    let startTime: Int
    let endTime: Int
    let eventType: String
    let locations: [Location] // Add locations property
    
    var id: String { eventId }

    // Property for managing favorites locally
    var isFavorite: Bool {
        get {
            return FavoritesManager.shared.isFavorite(eventId: eventId)
        }
        set {
            if newValue {
                FavoritesManager.shared.addFavorite(eventId: eventId)
            } else {
                FavoritesManager.shared.removeFavorite(eventId: eventId)
            }
        }
    }
    
    var formattedStartTime: String {
        formatDate(from: startTime)
    }
    
    var formattedEndTime: String {
        formatDate(from: endTime)
    }
    
    private func formatDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    struct Location: Codable, Identifiable {
        let id = UUID() // Unique identifier for each location
        let description: String
        let latitude: Double
        let longitude: Double
    }
}

