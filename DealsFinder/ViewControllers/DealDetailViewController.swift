//
//  DealDetailViewController.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import UIKit

class DealDetailViewController: UIViewController {

    // MARK: - Properties

    private let deal: Deal

    // MARK: - UI Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let storeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let savingsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discountBadge: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let categoryInfoView = InfoRowView(icon: "square.grid.2x2", title: "Category")
    private let locationInfoView = InfoRowView(icon: "mappin.circle", title: "Location")
    private let expiryInfoView = InfoRowView(icon: "calendar", title: "Expires")
    private let statsInfoView = InfoRowView(icon: "chart.bar", title: "Stats")

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let viewDealButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View Deal", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initialization

    init(deal: Deal) {
        self.deal = deal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithDeal()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Deal Details"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(dealImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(storeLabel)
        contentView.addSubview(priceContainerView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(detailsStackView)
        contentView.addSubview(viewDealButton)

        priceContainerView.addSubview(originalPriceLabel)
        priceContainerView.addSubview(discountedPriceLabel)
        priceContainerView.addSubview(savingsLabel)
        priceContainerView.addSubview(discountBadge)

        detailsStackView.addArrangedSubview(categoryInfoView)
        detailsStackView.addArrangedSubview(locationInfoView)
        detailsStackView.addArrangedSubview(expiryInfoView)
        detailsStackView.addArrangedSubview(statsInfoView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dealImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dealImageView.heightAnchor.constraint(equalToConstant: 250),

            favoriteButton.topAnchor.constraint(equalTo: dealImageView.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: dealImageView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),

            shareButton.topAnchor.constraint(equalTo: dealImageView.topAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.topAnchor.constraint(equalTo: dealImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            storeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            storeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            storeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            priceContainerView.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 16),
            priceContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceContainerView.heightAnchor.constraint(equalToConstant: 120),

            originalPriceLabel.topAnchor.constraint(equalTo: priceContainerView.topAnchor, constant: 16),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceContainerView.leadingAnchor, constant: 16),

            discountedPriceLabel.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor, constant: 8),
            discountedPriceLabel.leadingAnchor.constraint(equalTo: originalPriceLabel.leadingAnchor),

            savingsLabel.topAnchor.constraint(equalTo: discountedPriceLabel.bottomAnchor, constant: 8),
            savingsLabel.leadingAnchor.constraint(equalTo: originalPriceLabel.leadingAnchor),

            discountBadge.centerYAnchor.constraint(equalTo: priceContainerView.centerYAnchor),
            discountBadge.trailingAnchor.constraint(equalTo: priceContainerView.trailingAnchor, constant: -16),
            discountBadge.widthAnchor.constraint(equalToConstant: 80),
            discountBadge.heightAnchor.constraint(equalToConstant: 80),

            descriptionLabel.topAnchor.constraint(equalTo: priceContainerView.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            detailsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            viewDealButton.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 32),
            viewDealButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            viewDealButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            viewDealButton.heightAnchor.constraint(equalToConstant: 56),
            viewDealButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])

        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        viewDealButton.addTarget(self, action: #selector(viewDealButtonTapped), for: .touchUpInside)
    }

    private func configureWithDeal() {
        titleLabel.text = deal.title
        storeLabel.text = "🏪 \(deal.store)"
        descriptionLabel.text = deal.description
        discountedPriceLabel.text = deal.formattedDiscountedPrice
        savingsLabel.text = deal.formattedSavings
        discountBadge.text = "-\(deal.discountPercentage)%"
        favoriteButton.isSelected = deal.isFavorite

        let attributedString = NSAttributedString(
            string: deal.formattedOriginalPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        originalPriceLabel.attributedText = attributedString

        categoryInfoView.setValue(deal.category)
        locationInfoView.setValue(deal.location ?? (deal.isOnline ? "Online" : "N/A"))

        if let expiryDate = deal.expiryDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            expiryInfoView.setValue(formatter.string(from: expiryDate))
        } else {
            expiryInfoView.setValue("No expiry")
        }

        statsInfoView.setValue("❤️ \(deal.likes) likes • 👁 \(deal.views) views")
    }

    // MARK: - Actions

    @objc private func favoriteButtonTapped() {
        favoriteButton.isSelected.toggle()

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    @objc private func shareButtonTapped() {
        let text = "\(deal.title) - \(deal.formattedDiscountedPrice) at \(deal.store)"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @objc private func viewDealButtonTapped() {
        if let urlString = deal.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            let alert = UIAlertController(
                title: "Visit Store",
                message: "Visit \(deal.store) to get this deal!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

// MARK: - InfoRowView

class InfoRowView: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(icon: String, title: String) {
        super.init(frame: .zero)

        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title

        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 60),

            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValue(_ value: String) {
        valueLabel.text = value
    }
}
