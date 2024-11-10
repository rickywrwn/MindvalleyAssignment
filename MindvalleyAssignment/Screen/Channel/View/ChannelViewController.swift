//
//  ViewController.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

class ChannelViewController: UIViewController {
    weak var coordinator: ChannelCoordinator?
    let viewModel: ChannelViewModelProtocol
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Initialization
    init(viewModel: ChannelViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupBindings()
        
        // Fetch initial data
        viewModel.viewDidLoad()
    }
    
    // MARK: - Functions
    @objc private func refreshData() {
        viewModel.viewDidLoad()
    }
    
    private func handleStateChange(_ state: ViewState) {
        switch state {
        case .loading:
            if !refreshControl.isRefreshing {
                errorView.isHidden = true
                loadingView.startAnimating()
                collectionView.isHidden = true
                loadingView.alpha = 0
                loadingView.isHidden = false
                loadingView.startAnimating()
                
                UIView.animate(withDuration: 0.2) {
                    self.loadingView.alpha = 1
                }
            }

        case .loaded:
            let hasLoadingView = !loadingView.isHidden
            let hasErrorView = !errorView.isHidden
            
            // animate loading view out if it's visible
            if hasLoadingView {
                UIView.animate(withDuration: 0.3, animations: {
                    self.loadingView.alpha = 0
                }, completion: { _ in
                    self.loadingView.stopAnimating()
                    self.loadingView.isHidden = true
                })
            }
            
            // animate error view out if it's visible
            if hasErrorView {
                UIView.animate(withDuration: 0.3, animations: {
                    self.errorView.alpha = 0
                }, completion: { _ in
                    self.errorView.isHidden = true
                })
            }
            
            // show collection view
            collectionView.isHidden = false
            if !refreshControl.isRefreshing {
                collectionView.alpha = 0
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                    self.collectionView.alpha = 1
                }
            } else {
                refreshControl.endRefreshing()
            }
            
        case .error(let error):
            let hasLoadingView = !loadingView.isHidden
            
            if hasLoadingView {
                UIView.animate(withDuration: 0.3, animations: {
                    self.loadingView.alpha = 0
                }, completion: { _ in
                    self.loadingView.stopAnimating()
                    self.loadingView.isHidden = true
                    
                    self.showErrorView(with: error)
                })
            } else {
                showErrorView(with: error)
            }
            
            collectionView.isHidden = true
            refreshControl.endRefreshing()
            
        case .idle:
            loadingView.isHidden = true
            errorView.isHidden = true
            collectionView.isHidden = false
            refreshControl.endRefreshing()
        }
    }
    
    private func showErrorView(with error: Error) {
        errorView.alpha = 0
        errorView.isHidden = false
        errorView.configure(with: error)
        
        UIView.animate(withDuration: 0.3) {
            self.errorView.alpha = 1
        }
    }
    
    // MARK: - Setup Bindings
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
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .channelBackgroundColor
        setupNavigationTitle()
        setupCollectionView()
        setupRefreshControl()
        setupLoadingView()
        setupErrorView()
    }
    
    private func setupNavigationTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Channels"
        self.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.isTranslucent = true
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
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupErrorView() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        errorView.onRetry = { [weak self] in
            self?.viewModel.viewDidLoad()
        }
        
        errorView.onCancel = { [weak self] in
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
            self?.errorView.isHidden = true
        }
    }
    
    // MARK: - UI Components
    let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
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

