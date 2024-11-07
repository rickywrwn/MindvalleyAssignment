//
//  FooterCollectionViewCell.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import UIKit

class ChannelSectionFooterLineView: UICollectionReusableView {
    static let identifier = "SectionFooterLineView"
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .channelLineDividerColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

