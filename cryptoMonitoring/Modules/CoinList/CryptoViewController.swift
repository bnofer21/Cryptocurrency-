//
//  CryptoViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import UIKit
import Combine
import SkeletonView

final class CryptoViewController: UIViewController {
    
    // MARK: - Nested types
    
    enum Section {
        case all
    }
    
    enum Item: Hashable {
        case all([CoinUIModel])
        case fiat([CoinUIModel])
        case crypto([CoinUIModel])
        case loading(tag: String = UUID().uuidString)
        case error(tag: String = UUID().uuidString)
    }
    
    // MARK: - Private properties
    
    private let searchButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .close)
    private let searchBar = UISearchBar()
    
    private lazy var tabCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: createTabLayout()
    )
    private let selectView = UIView()
    private lazy var cryptoCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    private lazy var sectionDataSource = configureDataSource()
    
    private let viewModel: CryptoViewModel
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: CryptoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController methods
    
    override func loadView() {
        super.loadView()
        setup()
        viewModel.onLoadCrypto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutSkeletonIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(selectView)
        selectView.setDemission(.width(view.frame.width / 3))
        selectView.setDemission(.height(5))
        selectView.pinToSuperView(sides: .leftR)
        selectView.pin(side: .bottomR, to: .bottom(tabCollection))
        selectView.backgroundColor = .systemBlue
    }
    
}

// MARK: - Private methods

private extension CryptoViewController {
    func setup() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [cancelButton, searchButton])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        cancelButton.isHidden = true
        
        searchBar.delegate = self
        searchBar.isHidden = true
        navigationItem.titleView = searchBar
        title = "Cryptocurrencies"
        
        view.addSubview(tabCollection)
        tabCollection.pinToSafeArea(side: .topR, to: .top(view))
        tabCollection.pinToSuperView(sides: .leftR, .rightR)
        tabCollection.setDemission(.height(48))
        tabCollection.register(TabCell.self)
        tabCollection.isScrollEnabled = false
        tabCollection.delegate = self
        tabCollection.dataSource = self
        
        view.addSubview(cryptoCollection)
        cryptoCollection.pin(side: .topR, to: .bottom(tabCollection))
        cryptoCollection.pinToSuperView(sides: .leftR, .rightR, .bottomR)
        cryptoCollection.isPagingEnabled = true
        cryptoCollection.register(CryptoCollectionCell.self)
        cryptoCollection.contentInsetAdjustmentBehavior = .never
        cryptoCollection.delegate = self
        cryptoCollection.isSkeletonable = true
        cryptoCollection.showsHorizontalScrollIndicator = false
    }
    
    func bind() {
        viewModel.onModelPublisher
            .withUnretained(self)
            .receive(on: RunLoop.main)
            .sink { view, model in
                var snapshot = view.sectionDataSource.snapshot()
                let crypto = model.filter{ $0.type == .crypto }
                let fiat = model.filter{ $0.type == .fiat }
                snapshot.deleteAllItems()
                snapshot.appendSections([.all])
                snapshot.appendItems([
                    .all(model),
                    .crypto(crypto),
                    .fiat(fiat)
                ], toSection: .all)
                
                view.sectionDataSource.apply(snapshot)
            }
            .store(in: &cancellableSet)
        
        viewModel.onStatePublisher
            .withUnretained(self)
            .receive(on: RunLoop.main)
            .sink { view, state in
                var snapshot = view.sectionDataSource.snapshot()
                snapshot.deleteAllItems()
                snapshot.appendSections([.all])
                switch state {
                case .error:
                    snapshot.appendItems([.error(), .error(), .error()])
                case .loading:
                    snapshot.appendItems([.loading(), .loading(), .loading()])
                }
                
                view.sectionDataSource.apply(snapshot)
            }
            .store(in: &cancellableSet)
        
        searchButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.searchBar.isHidden = false
                view.cancelButton.isHidden = false
                view.searchButton.isHidden = true
                view.searchBar.becomeFirstResponder()
            }
            .store(in: &cancellableSet)
        
        cancelButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.searchBar.isHidden = true
                view.cancelButton.isHidden = true
                view.searchButton.isHidden = false
                view.searchBar.endEditing(true)
            }
            .store(in: &cancellableSet)
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section,Item> {
        return UICollectionViewDiffableDataSource<Section,Item>(collectionView: cryptoCollection) { collectionView, indexPath, type in
            let cell: CryptoCollectionCell = collectionView.dequeue(for: indexPath)
            switch type {
            case .all(let model),
                    .crypto(let model),
                    .fiat(let model):
                cell.configure(with: model)
            case .loading:
                cell.configureLoading()
            case .error:
                cell.configureError()
            }
            cell.output = self
            return cell
        }
    }
    
    func createTabLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width / 3, height: 48)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
    func createLayout() -> UICollectionViewLayout {
        let conf = UICollectionViewCompositionalLayoutConfiguration()
        conf.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            return NSCollectionLayoutSection(group: group)
        }, configuration: conf)
    }
}

// MARK: - UICollectionViewDelegate methods

extension CryptoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCollection {
            cryptoCollection.isPagingEnabled = false
            cryptoCollection.scrollToItem(at: indexPath, at: .left, animated: true)
            cryptoCollection.isPagingEnabled = true
        } 
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectView.frame.origin.x = scrollView.contentOffset.x / 3
    }
}

// MARK: - UICollectionViewDataSource methods

extension CryptoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == tabCollection else { return 0 }
        return viewModel.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == tabCollection else { return UICollectionViewCell() }
        let cell: TabCell = collectionView.dequeue(for: indexPath)
        cell.configure(with: viewModel.types[indexPath.row].title)
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
        return cell
    }
    
}

// MARK: - UISearchBarDelegate methods

extension CryptoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

// MARK: - CryptoCollectionCellOutput methods

extension CryptoViewController: CryptoCollectionCellOutput {
    
    func onLoadCrypto() {
        viewModel.onLoadCrypto()
    }
    
    func onLoadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.loadMore()
        }
    }
}
