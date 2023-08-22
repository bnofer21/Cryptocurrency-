//
//  LoadImageView.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import UIKit
import SkeletonView

let imageCache = NSCache<NSString, UIImage>()

class LoadImageView: UIImageView {
    
    // MARK: - Private properties
    
    private var urlString: String?
    
    // MARK: - Init
    
    public init(isSkeletonable: Bool = true) {
        super.init(frame: .zero)
        self.isSkeletonable = isSkeletonable
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    open func imageDidSet() {
        hideSkeleton()
    }
    
    public func loadImage(for urlString: String?) {
        showAnimatedGradientSkeleton()
        self.urlString = urlString
        guard let urlString else {
            imageDidSet()
            return
        }
        Task { @MainActor in
            if let savedImage = imageCache.object(forKey: NSString(string: urlString)) {
                await MainActor.run {
                    self.image = savedImage
                    self.imageDidSet()
                }
                return
            }
            let data = try await getImage(for: urlString, .low)
            guard let data else {
                imageDidSet()
                return
            }
            await MainActor.run {
                guard urlString == self.urlString,
                      let image = UIImage(data: data)
                else { return }
                self.image = image
                imageCache.setObject(image, forKey: NSString(string: urlString))
                self.imageDidSet()
            }
        }
    }
    
    public func getImage(for urlString: String?, _ priority: TaskPriority) async throws -> Data? {
        guard let urlString,
              let url = URL(string: urlString)
        else { return nil }
        
        return await withCheckedContinuation{ continuation in
            Task(priority: priority) {
                let request = URLRequest(url: url)
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                continuation.resume(returning: data)
            }
        }
    }
    
}
