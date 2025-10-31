//
//  DealsService.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import Foundation

class DealsService {

    static let shared = DealsService()

    private init() {}

    // MARK: - API Configuration

    private let baseURL = "https://api.dealsfinder.ca/v1"

    // MARK: - Fetch Deals

    func fetchDeals(category: String? = nil, completion: @escaping (Result<[Deal], Error>) -> Void) {
        // In a real app, this would make an actual API call
        // For now, we'll simulate a network call with sample data

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let category = category {
                let filtered = Deal.sampleDeals.filter { $0.category == category }
                completion(.success(filtered))
            } else {
                completion(.success(Deal.sampleDeals))
            }
        }
    }

    // MARK: - Search Deals

    func searchDeals(query: String, completion: @escaping (Result<[Deal], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let filtered = Deal.sampleDeals.filter { deal in
                deal.title.lowercased().contains(query.lowercased()) ||
                deal.description.lowercased().contains(query.lowercased()) ||
                deal.store.lowercased().contains(query.lowercased())
            }
            completion(.success(filtered))
        }
    }

    // MARK: - Fetch Deal Details

    func fetchDealDetails(id: String, completion: @escaping (Result<Deal, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let deal = Deal.sampleDeals.first(where: { $0.id == id }) {
                completion(.success(deal))
            } else {
                completion(.failure(NSError(domain: "DealsService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Deal not found"])))
            }
        }
    }

    // MARK: - Network Request (for future implementation)

    private func performRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "DealsService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DealsService", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
