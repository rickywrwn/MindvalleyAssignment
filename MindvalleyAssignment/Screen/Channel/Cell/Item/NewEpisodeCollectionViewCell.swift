//
//  NewEpisodeCollectionViewCell.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import UIKit

class NewEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewEpisodeCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryTextColor
        label.font = .roboto(type: .bold, size: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryTextColor
        label.font = .roboto(type: .bold, size: 13)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    private func setupUI() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 228),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with media: Media) {
        titleLabel.text = media .title ?? "Untitled"
        subtitleLabel.text = (media.channel?.title ?? "").uppercased()
        
        if let imageUrlString = media.coverAsset?.url, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2)), .cacheOriginalImage])
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
    }
}
