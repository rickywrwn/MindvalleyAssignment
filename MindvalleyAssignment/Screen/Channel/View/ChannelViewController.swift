//
//  ViewController.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

class ChannelViewController: UIViewController {
    weak var coordinator: ChannelCoordinator?
    private let viewModel: ChannelViewModelProtocol
    
    init(viewModel: ChannelViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .channelBackgroundColor
//        setupData()
        setupNavigationTitle()
        setupCollectionView()
        setupBindings()
        
        // Fetch initial data
        Task {
            await viewModel.fetchNewEpisode()
            await viewModel.fetchChannels()
            await viewModel.fetchCategories()
        }
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        viewModel.onStateChanged = { [weak self] state in
            self?.handleStateChange(state)
        }
        
        viewModel.onEpisodeDataChanged = {
            
        }
        
        viewModel.onChannelDataChanged = {
            
        }
        
        viewModel.onSectionDataChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
        
    }
    
    private func handleStateChange(_ state: ViewState) {
        switch state {
        case .loading:
//            activityIndicator.startAnimating()
//            updateButton.isEnabled = false
            print("")
            
        case .loaded:
//            activityIndicator.startAnimating()
//            updateButton.isEnabled = false
            print("")
            
        case .error(let error):
//            activityIndicator.startAnimating()
//            updateButton.isEnabled = false
            print("")
            
        case .idle:
//            activityIndicator.startAnimating()
//            updateButton.isEnabled = false
            print("")
        }
    }
    
    private func setupNavigationTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Channels"
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .channelBackgroundColor
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            
            let sectionType = self?.viewModel.sectionData?[sectionIndex].type
            switch sectionType {
            case .newEpisodes:
                return self?.createNewEpisodeSection()
            case .courses:
                return self?.createCourseSection()
            case .series:
                return self?.createSeriesSection()
            case .categories:
                return self?.createCategorySection()
            case .none:
                return self?.createNewEpisodeSection()
            }
            
        }
        return layout
    }
    
    private func createNewEpisodeSection() -> NSCollectionLayoutSection {
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
    
    private func createCourseSection() -> NSCollectionLayoutSection {
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 10, trailing: 0)
        section.interGroupSpacing = 20

        
        // Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
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

    private func createSeriesSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 10, trailing: 0)
        section.interGroupSpacing = 20

        
        // Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
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

    private func createCategorySection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(15)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 16
        
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
        
        //item cell
        collectionView.register(NewEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: NewEpisodeCollectionViewCell.identifier)
        collectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: CourseCollectionViewCell.identifier)
        collectionView.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        //header cell
        collectionView.register(TextSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TextSectionHeaderView.identifier)
        collectionView.register(CourseSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CourseSectionHeaderView.identifier)
        
        //footer cell
        collectionView.register(ChannelSectionFooterLineView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ChannelSectionFooterLineView.identifier)
                
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
}


extension ChannelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionDataCount = viewModel.sectionData?.count ?? 1
        
        if section != 0 && section != sectionDataCount - 1 {
            return min(viewModel.sectionData?[section].items.count ?? 0, 6)
        }
        return viewModel.sectionData?[section].items.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let item = viewModel.sectionData?[indexPath.section].items[indexPath.item]
            
            switch item {
            case .newEpisode(let media):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewEpisodeCollectionViewCell.identifier,
                    for: indexPath
                ) as? NewEpisodeCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: media)
                return cell
                
            case .course(let course):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CourseCollectionViewCell.identifier,
                    for: indexPath
                ) as? CourseCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: course)
                return cell
                
            case .series(let series):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SeriesCollectionViewCell.identifier,
                    for: indexPath
                ) as? SeriesCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: series)
                return cell
                
            case .category(let category):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryCollectionViewCell.identifier,
                    for: indexPath
                ) as? CategoryCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: category)
                return cell
            case .none:
                return UICollectionViewCell()
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let section = viewModel.sectionData?[indexPath.section]
            
            if kind == UICollectionView.elementKindSectionHeader {
                switch section?.type {
                case .courses, .series:
                    guard let headerView = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: CourseSectionHeaderView.identifier,
                        for: indexPath
                    ) as? CourseSectionHeaderView else {
                        return UICollectionReusableView()
                    }
                    headerView.configure(title: section?.title ?? "", subtitle: section?.subtitle ?? "", imageUrlString: section?.iconUrl ?? "")
                    return headerView
                case .newEpisodes:
                    guard let headerView = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: TextSectionHeaderView.identifier,
                        for: indexPath
                    ) as? TextSectionHeaderView else {
                        return UICollectionReusableView()
                    }
                    headerView.configure(title: section?.title ?? "")
                    return headerView
                default:
                    guard let headerView = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: TextSectionHeaderView.identifier,
                        for: indexPath
                    ) as? TextSectionHeaderView else {
                        return UICollectionReusableView()
                    }
//                    headerView.configure(title: section.type.title)
                    return headerView
                }
            } else if kind == UICollectionView.elementKindSectionFooter {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ChannelSectionFooterLineView.identifier,
                    for: indexPath
                ) as? ChannelSectionFooterLineView else {
                    return UICollectionReusableView()
                }
                
                if let sectionDataCount = viewModel.sectionData?.count, sectionDataCount > 0{
                    footerView.isHidden = indexPath.section == sectionDataCount - 1
                }
                
                
                return footerView
            }
            
            return UICollectionReusableView()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
