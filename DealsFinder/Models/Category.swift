//
//  Category.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import Foundation
import UIKit

struct Category: Identifiable {
    let id: String
    let name: String
    let iconName: String
    let dealCount: Int

    var icon: UIImage? {
        return UIImage(systemName: iconName)
    }
}

extension Category {
    static var allCategories: [Category] {
        return [
            Category(id: "1", name: "Electronics", iconName: "laptopcomputer", dealCount: 156),
            Category(id: "2", name: "Fashion", iconName: "tshirt.fill", dealCount: 234),
            Category(id: "3", name: "Home & Kitchen", iconName: "house.fill", dealCount: 189),
            Category(id: "4", name: "Gaming", iconName: "gamecontroller.fill", dealCount: 98),
            Category(id: "5", name: "Sports & Outdoors", iconName: "figure.walk", dealCount: 142),
            Category(id: "6", name: "Beauty & Health", iconName: "heart.text.square.fill", dealCount: 167),
            Category(id: "7", name: "Grocery", iconName: "cart.fill", dealCount: 321),
            Category(id: "8", name: "Automotive", iconName: "car.fill", dealCount: 76),
            Category(id: "9", name: "Books & Media", iconName: "book.fill", dealCount: 112),
            Category(id: "10", name: "Toys & Kids", iconName: "figure.and.child.holdinghands", dealCount: 145),
            Category(id: "11", name: "Travel", iconName: "airplane", dealCount: 87),
            Category(id: "12", name: "Restaurants", iconName: "fork.knife", dealCount: 203)
        ]
    }
}
