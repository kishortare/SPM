//
//  DealTableViewCell.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {

    static let identifier = "DealTableViewCell"

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let storeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discountBadge: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(containerView)

        containerView.addSubview(dealImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(storeLabel)
        containerView.addSubview(originalPriceLabel)
        containerView.addSubview(discountedPriceLabel)
        containerView.addSubview(discountBadge)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            dealImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dealImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dealImageView.widthAnchor.constraint(equalToConstant: 100),
            dealImageView.heightAnchor.constraint(equalToConstant: 100),

            discountBadge.topAnchor.constraint(equalTo: dealImageView.topAnchor, constant: 8),
            discountBadge.trailingAnchor.constraint(equalTo: dealImageView.trailingAnchor, constant: -8),
            discountBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            discountBadge.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: dealImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),

            storeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            storeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            storeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            originalPriceLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 8),
            originalPriceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            discountedPriceLabel.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor, constant: 2),
            discountedPriceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            categoryLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            categoryLabel.leadingAnchor.constraint(equalTo: dealImageView.trailingAnchor, constant: 12),

            favoriteButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Configuration

    func configure(with deal: Deal) {
        titleLabel.text = deal.title
        storeLabel.text = deal.store
        discountedPriceLabel.text = deal.formattedDiscountedPrice
        discountBadge.text = "-\(deal.discountPercentage)%"
        categoryLabel.text = deal.category
        favoriteButton.isSelected = deal.isFavorite

        // Strike through original price
        let attributedString = NSAttributedString(
            string: deal.formattedOriginalPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        originalPriceLabel.attributedText = attributedString

        // Set placeholder image
        dealImageView.image = UIImage(systemName: "photo")
        dealImageView.tintColor = .systemGray3
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dealImageView.image = nil
        titleLabel.text = nil
        storeLabel.text = nil
        originalPriceLabel.text = nil
        discountedPriceLabel.text = nil
        discountBadge.text = nil
        categoryLabel.text = nil
        favoriteButton.isSelected = false
    }
}
