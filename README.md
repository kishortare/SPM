# DealsFinder - iOS Deals App for Canada

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift">
  <img src="https://img.shields.io/badge/iOS-14.0+-green.svg" alt="iOS">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>

## Overview

**DealsFinder** is a modern iOS application designed to help users in Canada discover the best deals across various categories including electronics, fashion, home & kitchen, gaming, and more. Similar to emoney, this app aggregates deals from multiple retailers and presents them in an easy-to-browse interface.

## Features

### 🏷️ Core Features

- **Browse Deals**: View all available deals with detailed information
- **Categories**: Browse deals by 12+ categories including Electronics, Fashion, Grocery, Travel, and more
- **Deal Details**: See comprehensive information about each deal including:
  - Original and discounted prices
  - Discount percentage
  - Store information
  - Expiry dates
  - Deal popularity (likes and views)
  - Online/In-store availability

### 🔍 Search & Filter

- **Smart Search**: Search deals by title, store name, or category
- **Filter Options**: Filter by Online only, In-store only, or All deals
- **Sort Options**:
  - Highest Discount
  - Lowest Price
  - Most Popular
  - Ending Soon

### ❤️ Favorites

- **Save Favorites**: Mark deals as favorites with a single tap
- **Favorites Management**: View all saved deals in one place
- **Swipe to Remove**: Easy removal of favorites with swipe gestures

### 📱 User Interface

- **Modern Design**: Clean, intuitive interface with iOS design guidelines
- **Tab-based Navigation**: Easy access to Deals, Categories, and Favorites
- **Dark Mode Support**: Automatic support for light and dark modes
- **Smooth Animations**: Polished user experience with smooth transitions

## Architecture

The app follows a clean architecture pattern with clear separation of concerns:

```
DealsFinder/
├── App/
│   ├── AppDelegate.swift          # App lifecycle management
│   └── SceneDelegate.swift        # Scene configuration
├── Models/
│   ├── Deal.swift                 # Deal data model
│   └── Category.swift             # Category data model
├── Views/
│   └── DealTableViewCell.swift    # Custom table cell for deals
├── ViewControllers/
│   ├── DealsListViewController.swift       # Main deals listing
│   ├── DealDetailViewController.swift      # Deal details screen
│   ├── CategoriesViewController.swift      # Categories browser
│   └── FavoritesViewController.swift       # Saved favorites
├── Services/
│   ├── DealsService.swift         # Networking and API calls
│   └── FavoritesManager.swift     # Favorites persistence
└── Utilities/
    └── Constants.swift            # App-wide constants
```

## Requirements

- **iOS**: 14.0 or later
- **Xcode**: 14.0 or later
- **Swift**: 5.9 or later

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/DealsFinder.git
cd DealsFinder
```

### 2. Open in Xcode

```bash
open DealsFinder.xcodeproj
```

### 3. Build and Run

- Select your target device or simulator
- Press `Cmd + R` to build and run

## Usage

### Browsing Deals

1. Launch the app to see the main deals feed
2. Use the segmented control to filter between All, Online, and In-store deals
3. Tap the sort button to organize deals by discount, price, popularity, or expiry
4. Pull down to refresh the deals list

### Searching

1. Tap the search bar at the top
2. Enter keywords to search for deals
3. Results update in real-time as you type

### Viewing Deal Details

1. Tap any deal card to see full details
2. View pricing information, description, and store details
3. Tap "View Deal" to visit the store (if online)
4. Use the favorite button to save the deal
5. Use the share button to share with friends

### Managing Favorites

1. Navigate to the Favorites tab
2. View all your saved deals
3. Swipe left on any deal to remove it from favorites
4. Tap any deal to view its details

### Browsing Categories

1. Navigate to the Categories tab
2. Browse 12+ categories with deal counts
3. Tap any category to view deals in that category

## Data Models

### Deal Model

```swift
struct Deal {
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
}
```

### Category Model

```swift
struct Category {
    let id: String
    let name: String
    let iconName: String
    let dealCount: Int
}
```

## API Integration

The app is designed to work with a RESTful API. Currently using sample data, but ready for integration:

### Endpoints (Future Implementation)

- `GET /deals` - Fetch all deals
- `GET /deals/:id` - Fetch deal details
- `GET /categories` - Fetch categories
- `GET /search?q=query` - Search deals

### Sample Integration

```swift
DealsService.shared.fetchDeals { result in
    switch result {
    case .success(let deals):
        // Update UI with deals
    case .failure(let error):
        // Handle error
    }
}
```

## Customization

### Theming

The app uses system colors that automatically adapt to dark mode. To customize:

1. Open `AppDelegate.swift`
2. Modify the `configureAppearance()` method
3. Update colors in navigation bar and tab bar appearances

### Sample Data

To modify sample data for testing:

1. Open `Models/Deal.swift`
2. Edit the `sampleDeals` static property
3. Open `Models/Category.swift`
4. Edit the `allCategories` static property

## Future Enhancements

### Planned Features

- [ ] User authentication and profiles
- [ ] Push notifications for new deals
- [ ] Price tracking and alerts
- [ ] Deal submission by users
- [ ] Social sharing integration
- [ ] Map view for in-store deals
- [ ] Barcode scanning
- [ ] Deal comments and ratings
- [ ] Personalized recommendations
- [ ] Widget support

### Technical Improvements

- [ ] Integration with real API backend
- [ ] Image caching and loading
- [ ] Offline support
- [ ] Analytics integration
- [ ] Unit and UI tests
- [ ] CI/CD pipeline

## Technologies Used

- **UIKit**: For building the user interface
- **Foundation**: Core iOS frameworks
- **UserDefaults**: For local data persistence
- **URLSession**: For networking (ready for API integration)

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Code Style

- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use MARK comments to organize code

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

- **Project Maintainer**: DealsFinder Team
- **Email**: support@dealsfinder.ca
- **Issues**: [GitHub Issues](https://github.com/yourusername/DealsFinder/issues)

## Acknowledgments

- Inspired by emoney and other deal-finding applications
- Icons from SF Symbols
- Design inspiration from iOS Human Interface Guidelines

## Screenshots

### Main Deals Feed
Browse all available deals with prices, discounts, and store information.

### Deal Details
View comprehensive information about each deal including pricing, description, and availability.

### Categories
Browse deals organized by categories like Electronics, Fashion, Grocery, and more.

### Favorites
Save and manage your favorite deals for quick access.

---

**Made with ❤️ in Canada**
