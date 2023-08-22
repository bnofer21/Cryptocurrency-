//
//  CryptoCollectionCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class CryptoCollectionCell: UICollectionViewCell {
    
    // MARK: - Nested types
    
    enum Section {
        case coin
        case loading
        case error
    }
    
    enum Item: Hashable {
        case coin(CoinUIModel)
        case loading(tag: String = UUID().uuidString)
        case error
        case more
    }
    
    // MARK: - Properties
    
    var output: CryptoCollectionCellOutput?
    
    // MARK: - Private properties
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    private lazy var coinDataSource = configureDataSource()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with model: [CoinUIModel]) {
        var snapshot = coinDataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.coin])
        snapshot.appendItems(model.compactMap{ .coin($0) }, toSection: .coin)
        snapshot.appendItems([.more], toSection: .coin)
        
        coinDataSource.apply(snapshot)
    }
    
    func configureLoading() {
        var snapshot = coinDataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.loading])
        snapshot.appendItems([.loading(), .loading(), .loading(), .loading(), .loading(), .loading(), .loading(), .loading(), .loading(), .loading()])
        coinDataSource.apply(snapshot)
    }
    
    func configureError() {
        var snapshot = coinDataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.error])
        snapshot.appendItems([.error])
        
        coinDataSource.apply(snapshot)
    }
}

// MARK: - Private methods

private extension CryptoCollectionCell {
    func setup() {
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.register(CryptoCell.self)
        collectionView.register(CryptoLoadingCell.self)
        collectionView.register(CryptoErrorCell.self)
        collectionView.register(CryptoMoreCell.self)
        collectionView.isSkeletonable = true
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, model in
            switch model {
            case .coin(let model):
                let cell: CryptoCell = collectionView.dequeue(for: indexPath)
                cell.configue(with: model)
                return cell
            case .loading:
                let cell: CryptoLoadingCell = collectionView.dequeue(for: indexPath)
                return cell
            case .error:
                let cell: CryptoErrorCell = collectionView.dequeue(for: indexPath)
                return cell
            case .more:
                let cell: CryptoMoreCell = collectionView.dequeue(for: indexPath)
                cell.startLoading()
                return cell
            }

        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(64)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            return NSCollectionLayoutSection(group: group)
        }
    }
}

// MARK: - UICollectionViewDelegate methods

extension CryptoCollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath)
                as? CryptoErrorCell
        else { return }
        output?.onLoadCrypto()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let _ = cell as? CryptoMoreCell
        else { return }
        output?.onLoadMore()
    }
}
