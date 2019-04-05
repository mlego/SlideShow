//
//  ShowEngine.swift
//  ShowEngineFramework
//
//  Created by Martin Legowiecki on 4/3/19.
//

import Foundation
import Alamofire
import Keys

public enum ImageSize {
    case raw
    case full
    case regular
    case small
    case thumb
}

public class ShowEngine {
    
    private var showTimer: Timer?
    private var imageSize: ImageSize
    private var imageCache: [ShowEngineModel]
    
    public init(imageSize: ImageSize) {
        self.imageSize = imageSize
        self.imageCache = []
    }
    
    // MARK: - Show Engine Run Loop
    public func start() {
        
        getNextImage() { [weak self] in
            if let result = $0 {
                self?.loadImage(imageData: result) { [weak self] in
                    if let result = $0 {
                        print("Image loaded & ready for display: \(result)")
                        
                        self?.showTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { [weak self] timer in
                            self?.start()
                        })
                        
                    } else {
                        print("Couldn't load image")
                        self?.stop()
                    }
                }
            } else {
                print("Couldn't load data")
                self?.stop()
            }
        }
    }
    
    private func getNextImage(completion: @escaping (ShowEngineModel?) -> Void) {
        if imageCache.isEmpty {
            loadData() { [weak self] in
                if let result = $0 {
                    self?.imageCache = result
                    completion(self?.imageCache.popLast())
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(imageCache.popLast())
        }
    }
    
    public func stop() {
        stopTimer()
    }
    
    private func stopTimer() {
        if showTimer != nil {
            showTimer?.invalidate()
        }
    }

    
    // MARK: - Data & Image Load
    private func loadData(completion: @escaping ([ShowEngineModel]?) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(Keys().unsplashAccessKey)"]

        Alamofire.request("https://api.unsplash.com/photos/random?count=10", headers: headers).responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode([ShowEngineModel].self, from: response.data!)
                print("Loaded data, count: \(result.count)")
                completion(result)
            } catch {
                completion(nil)
            }
        }
    }
    
    private func loadImage(imageData: ShowEngineModel, completion: @escaping (Data?) -> Void) {
        if let imageURL = getImageURL(urls: imageData.images) {
            Alamofire.request(imageURL).responseData { response in
                if let image = response.result.value {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func getImageURL(urls: ShowEngineModel.Images) -> String? {
        var resultURL: String?
        
        switch imageSize {
        case .full:
            resultURL = urls.full
        case .raw:
            resultURL = urls.raw
        case .regular:
            resultURL = urls.regular
        case .small:
            resultURL = urls.small
        case .thumb:
            resultURL = urls.thumb
        }
        
        return resultURL
    }
    
    deinit {
        stopTimer()
    }
}
