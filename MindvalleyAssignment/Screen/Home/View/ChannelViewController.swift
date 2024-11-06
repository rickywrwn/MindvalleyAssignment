//
//  ViewController.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

class ChannelViewController: UIViewController {
    weak var coordinator: ChannelCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .channelBackgroundColor
        setupNavigationTitle()
        setupCollectionView()
    }
    
    private func setupNavigationTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Channels"
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .channelBackgroundColor
        
        //item cell
        collectionView.register(NewEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: NewEpisodeCollectionViewCell.identifier)
        
        //header cell
        collectionView.register(NewEpisodeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewEpisodeSectionHeaderView.identifier)
        
        //footer cell
        collectionView.register(SectionFooterLineView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterLineView.identifier)
                
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let section = createSection()
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    private func createSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 0)
        section.interGroupSpacing = 20

        
        // Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // Footer
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(41) //margin + line weight
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        section.boundarySupplementaryItems = [header, footer]
        
        return section
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}



extension ChannelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewEpisodeCollectionViewCell.identifier, for: indexPath) as? NewEpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 1{
            
            cell.configure(title: "Evolved Enterprise", subtitle: "Impact At Work", image: nil)
        }else{
            
            cell.configure(title: "The Cure For Loneliness", subtitle: "Mindvalley Mentoring Mindvalley Mentoring Mindvalley Mentoring Mindvalley Mentoring", image: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: NewEpisodeSectionHeaderView.identifier,
                for: indexPath
            ) as? NewEpisodeSectionHeaderView else {
                return UICollectionReusableView()
            }
            
            headerView.configure(with: "New Episodes")
            return headerView
            
        }else if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: SectionFooterLineView.identifier, for: indexPath
            ) as? SectionFooterLineView else {
                return UICollectionReusableView()
            }
                        
            // Don't show footer line for the last section
            if indexPath.section == numberOfSections(in: collectionView) - 1 {
                footerView.isHidden = true
            } else {
                footerView.isHidden = false
            }
            
            return footerView
        }

        return UICollectionReusableView()
    }
}
