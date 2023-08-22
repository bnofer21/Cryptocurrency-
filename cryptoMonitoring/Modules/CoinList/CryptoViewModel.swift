//
//  CryptoViewModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import Combine

final class CryptoViewModel {
    
    // MARK: - Properties
    
    var onModelPublisher: AnyPublisher<[CoinUIModel], Never> {
        onModelSubject.eraseToAnyPublisher()
    }
    
    var onStatePublisher: AnyPublisher<LoadingType, Never> {
        onStateSubject.eraseToAnyPublisher()
    }
    
    let types: [CoinType] = [
        .all,
        .crypto,
        .fiat
    ]
    
    // MARK: - Private properties
    
    private var model = [CoinUIModel]()
    private var visibleModel = [CoinUIModel]()
    
    private let cryptoService: CryptoService
    
    private let onModelSubject = PassthroughSubject<[CoinUIModel], Never>()
    private let onStateSubject = PassthroughSubject<LoadingType, Never>()
    private let onTryAgainSubject = PassthroughSubject<Void, Never>()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    private var output: CryptoOutput
    
    // MARK: - Init
    
    init(
        cryptoService: CryptoService,
        output: CryptoOutput
    ) {
        self.cryptoService = cryptoService
        self.output = output
        bind()
    }
    
    // MARK: - Methods
    
    func onLoadCrypto() {
        onStateSubject.send(.loading)
        cryptoService.loadCrypto()
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sink { [weak self] error in
                guard case .failure(let error) = error,
                      let self
                else { return }
                if let error = error as? CustomError {
                    self.output.show(
                        error,
                        tryAgainSubject: self.onTryAgainSubject
                    )
                }
                self.onStateSubject.send(.error)
            } receiveValue: { vm, model in
                vm.model = vm.prepareUI(model)
                vm.visibleModel = vm.model[...49].compactMap{ $0 }
                vm.onModelSubject.send(vm.visibleModel)
            }
            .store(in: &cancellableSet)
    }
    
    func loadMore() {
        visibleModel = model[0...visibleModel.count+50].compactMap{ $0 }
        onModelSubject.send(visibleModel)
    }
    
    func search(_ text: String) {
        onStateSubject.send(.loading)
        guard !text.isEmpty else {
            onModelSubject.send(visibleModel)
            return
        }
        let searchModel = model.filter { coin in
            return coin.ticker.contains(text)
            || coin.ticker.contains(text.uppercased())
            || coin.ticker.contains(text.lowercased())
            || coin.ticker.lowercased().contains(text)
            || coin.ticker.lowercased().contains(text.lowercased())
            || coin.ticker.lowercased().contains(text.uppercased())
            || coin.ticker.uppercased().contains(text)
            || coin.ticker.uppercased().contains(text.uppercased())
            || coin.ticker.uppercased().contains(text.lowercased())
            || coin.name.contains(text)
            || coin.name.contains(text.uppercased())
            || coin.name.contains(text.lowercased())
            || coin.name.lowercased().contains(text)
            || coin.name.lowercased().contains(text.lowercased())
            || coin.name.lowercased().contains(text.uppercased())
            || coin.name.uppercased().contains(text)
            || coin.name.uppercased().contains(text.uppercased())
            || coin.name.uppercased().contains(text.lowercased())
        }
        onModelSubject.send(searchModel)
    }
}

// MARK: - Private properties

private extension CryptoViewModel {
    
    func bind() {
        onTryAgainSubject
            .withUnretained(self)
            .sink { vm, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    vm.onLoadCrypto()
                }
            }
            .store(in: &cancellableSet)
    }
    
    func prepareUI(_ model: [CoinEntry]) -> [CoinUIModel] {
        return model.compactMap{
            CoinUIModel(
                id: $0.idIcon ?? "",
                type: CoinType(rawValue: $0.moneyType) ?? .all,
                ticker: $0.ticker,
                name: $0.fullName,
                price: preparePrice($0.price),
                image: prepareImageUrl($0.idIcon)
            )
        }
    }
    
    func prepareImageUrl(_ id: String?) -> String {
        guard let id else { return "" }
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = id.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        return urlString
    }
    
    func preparePrice(_ price: Double?) -> String {
        guard let price else { return "" }
        switch price {
        case ..<10:
            return String(format: "%.6f", price)
        case 10..<100:
            return String(format: "%.5f", price)
        case 100..<1000:
            return String(format: "%.4f", price)
        case 1000..<10000:
            return String(format: "%.3f", price)
        default:
            return String(format: "%.2f", price)
        }
    }
}
