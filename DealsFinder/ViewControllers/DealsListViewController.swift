//
//  DealsListViewController.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import UIKit

class DealsListViewController: UIViewController {

    // MARK: - Properties

    private var deals: [Deal] = Deal.sampleDeals
    private var filteredDeals: [Deal] = []
    private var isSearching = false

    // MARK: - UI Components

    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search deals..."
        return controller
    }()

    private let segmentedControl: UISegmentedControl = {
        let items = ["All", "Online", "In-Store"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupTableView()
        setupSearchController()
    }

    // MARK: - Setup

    private func setupUI() {
        title = "Deals in Canada"
        view.backgroundColor = .systemBackground

        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        let sortButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )

        navigationItem.rightBarButtonItem = sortButton
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        definesPresentationContext = true
    }

    // MARK: - Actions

    @objc private func segmentChanged() {
        filterDeals()
    }

    @objc private func sortButtonTapped() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Highest Discount", style: .default) { [weak self] _ in
            self?.sortDeals(by: .discount)
        })

        alert.addAction(UIAlertAction(title: "Lowest Price", style: .default) { [weak self] _ in
            self?.sortDeals(by: .price)
        })

        alert.addAction(UIAlertAction(title: "Most Popular", style: .default) { [weak self] _ in
            self?.sortDeals(by: .popularity)
        })

        alert.addAction(UIAlertAction(title: "Ending Soon", style: .default) { [weak self] _ in
            self?.sortDeals(by: .expiry)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    // MARK: - Helper Methods

    private func filterDeals() {
        let selectedIndex = segmentedControl.selectedSegmentIndex

        switch selectedIndex {
        case 0: // All
            deals = Deal.sampleDeals
        case 1: // Online
            deals = Deal.sampleDeals.filter { $0.isOnline }
        case 2: // In-Store
            deals = Deal.sampleDeals.filter { !$0.isOnline }
        default:
            deals = Deal.sampleDeals
        }

        tableView.reloadData()
    }

    private func sortDeals(by sortType: SortType) {
        switch sortType {
        case .discount:
            deals.sort { $0.discountPercentage > $1.discountPercentage }
        case .price:
            deals.sort { $0.discountedPrice < $1.discountedPrice }
        case .popularity:
            deals.sort { $0.likes > $1.likes }
        case .expiry:
            deals.sort { ($0.expiryDate ?? Date.distantFuture) < ($1.expiryDate ?? Date.distantFuture) }
        }

        tableView.reloadData()
    }

    private enum SortType {
        case discount, price, popularity, expiry
    }
}

// MARK: - UITableViewDataSource

extension DealsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredDeals.count : deals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DealTableViewCell.identifier,
            for: indexPath
        ) as? DealTableViewCell else {
            return UITableViewCell()
        }

        let deal = isSearching ? filteredDeals[indexPath.row] : deals[indexPath.row]
        cell.configure(with: deal)
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - UITableViewDelegate

extension DealsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deal = isSearching ? filteredDeals[indexPath.row] : deals[indexPath.row]
        let detailVC = DealDetailViewController(deal: deal)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension DealsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredDeals = deals.filter { deal in
            deal.title.lowercased().contains(searchText.lowercased()) ||
            deal.store.lowercased().contains(searchText.lowercased()) ||
            deal.category.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
}

// MARK: - UISearchControllerDelegate

extension DealsListViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        isSearching = false
        tableView.reloadData()
    }
}
