//
//  CourseSectionHeaderView.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import UIKit
import Kingfisher

class CourseSectionHeaderView: UICollectionReusableView {
    static let identifier = "CourseSectionHeaderView"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryTextColor
        label.font = .roboto(type: .bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryTextColor
        label.font = .roboto(type: .bold, size: 16)
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
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -0.5),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 0.5),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configure(title: String, subtitle: String, imageUrlString: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        if let imageUrl = URL(string: imageUrlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: imageUrl,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        // In case of any error (including 404), show placeholder
                        self.imageView.image = UIImage(named: "placeholderImage")
                    }
                }
            )
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
    }
}

