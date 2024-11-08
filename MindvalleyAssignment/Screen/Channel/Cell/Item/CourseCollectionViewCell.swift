//
//  CourseCollectionViewCell.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    static let identifier = "CourseCollectionViewCell"
    
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
    }
    
    private func setupUI() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 228),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with channel: Media) {
        
        titleLabel.text = channel.title ?? "Untitled"
        
        if let imageUrlString = channel.coverAsset?.url, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl, options: [.transition(.fade(0.1)), .cacheOriginalImage])
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
    }
}

