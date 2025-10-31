//
//  Constants.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import Foundation

struct Constants {

    // MARK: - API

    struct API {
        static let baseURL = "https://api.dealsfinder.ca/v1"
        static let dealsEndpoint = "/deals"
        static let categoriesEndpoint = "/categories"
        static let searchEndpoint = "/search"
    }

    // MARK: - UserDefaults Keys

    struct UserDefaultsKeys {
        static let favorites = "savedFavorites"
        static let lastRefresh = "lastRefreshDate"
        static let selectedRegion = "selectedRegion"
    }

    // MARK: - Notifications

    struct Notifications {
        static let favoriteUpdated = "favoriteUpdated"
        static let dealsRefreshed = "dealsRefreshed"
    }

    // MARK: - App Info

    struct AppInfo {
        static let appName = "DealsFinder"
        static let version = "1.0.0"
        static let supportEmail = "support@dealsfinder.ca"
    }

    // MARK: - UI Constants

    struct UI {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
        static let cellHeight: CGFloat = 120
    }
}
