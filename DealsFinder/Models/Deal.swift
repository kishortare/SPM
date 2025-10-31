//
//  Deal.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import Foundation

struct Deal: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let originalPrice: Double
    let discountedPrice: Double
    let discountPercentage: Int
    let category: String
    let store: String
    let imageURL: String?
    let expiryDate: Date?
    let isOnline: Bool
    let location: String?
    let url: String?
    let likes: Int
    let views: Int

    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case originalPrice = "original_price"
        case discountedPrice = "discounted_price"
        case discountPercentage = "discount_percentage"
        case category
        case store
        case imageURL = "image_url"
        case expiryDate = "expiry_date"
        case isOnline = "is_online"
        case location
        case url
        case likes
        case views
    }

    // Computed property for savings
    var savings: Double {
        return originalPrice - discountedPrice
    }

    // Formatted prices
    var formattedOriginalPrice: String {
        return String(format: "$%.2f", originalPrice)
    }

    var formattedDiscountedPrice: String {
        return String(format: "$%.2f", discountedPrice)
    }

    var formattedSavings: String {
        return String(format: "Save $%.2f", savings)
    }

    // Check if deal is still valid
    var isValid: Bool {
        guard let expiryDate = expiryDate else { return true }
        return expiryDate > Date()
    }
}

// Sample data for testing
extension Deal {
    static var sampleDeals: [Deal] {
        return [
            Deal(
                id: "1",
                title: "Samsung 65\" 4K Smart TV",
                description: "Amazing deal on Samsung 65 inch 4K Smart TV with HDR support. Limited time offer!",
                originalPrice: 1299.99,
                discountedPrice: 799.99,
                discountPercentage: 38,
                category: "Electronics",
                store: "Best Buy",
                imageURL: nil,
                expiryDate: Date().addingTimeInterval(7 * 24 * 60 * 60),
                isOnline: true,
                location: "Canada-wide",
                url: "https://bestbuy.ca",
                likes: 245,
                views: 1203,
                isFavorite: false
            ),
            Deal(
                id: "2",
                title: "iPhone 15 Pro - 50% Off Second Device",
                description: "Get 50% off on a second iPhone 15 Pro when you purchase one at full price.",
                originalPrice: 1399.99,
                discountedPrice: 699.99,
                discountPercentage: 50,
                category: "Electronics",
                store: "Rogers",
                imageURL: nil,
                expiryDate: Date().addingTimeInterval(14 * 24 * 60 * 60),
                isOnline: false,
                location: "Toronto, ON",
                url: nil,
                likes: 523,
                views: 2456,
                isFavorite: true
            ),
            Deal(
                id: "3",
                title: "Nike Air Max 90 - Clearance Sale",
                description: "Classic Nike Air Max 90 sneakers at clearance prices. Multiple colors available.",
                originalPrice: 179.99,
                discountedPrice: 89.99,
                discountPercentage: 50,
                category: "Fashion",
                store: "Sport Chek",
                imageURL: nil,
                expiryDate: Date().addingTimeInterval(3 * 24 * 60 * 60),
                isOnline: true,
                location: "Canada-wide",
                url: "https://sportchek.ca",
                likes: 178,
                views: 892,
                isFavorite: false
            ),
            Deal(
                id: "4",
                title: "Instant Pot Duo 7-in-1",
                description: "Multi-functional pressure cooker, slow cooker, rice cooker, and more!",
                originalPrice: 149.99,
                discountedPrice: 79.99,
                discountPercentage: 47,
                category: "Home & Kitchen",
                store: "Amazon.ca",
                imageURL: nil,
                expiryDate: Date().addingTimeInterval(2 * 24 * 60 * 60),
                isOnline: true,
                location: "Canada-wide",
                url: "https://amazon.ca",
                likes: 412,
                views: 1567,
                isFavorite: false
            ),
            Deal(
                id: "5",
                title: "PlayStation 5 Bundle with 2 Games",
                description: "PS5 console bundle with God of War Ragnarök and Spider-Man 2.",
                originalPrice: 749.99,
                discountedPrice: 649.99,
                discountPercentage: 13,
                category: "Gaming",
                store: "Walmart",
                imageURL: nil,
                expiryDate: Date().addingTimeInterval(5 * 24 * 60 * 60),
                isOnline: true,
                location: "Canada-wide",
                url: "https://walmart.ca",
                likes: 687,
                views: 3421,
                isFavorite: true
            )
        ]
    }
}
