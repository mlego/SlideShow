// Copyright © 2019 mlego. All rights reserved.

import Foundation
import Alamofire
import Keys

public protocol ShowEngineInput: AnyObject {
    func start()
    func stop()
}

public protocol ShowEngineOutput: AnyObject {
    func imageLoadSuccess(data: ShowEngineModel)
    func imageLoadFailure()
}

public enum ImageSize {
    case raw
    case full
    case regular
    case small
    case thumb
}

public final class ShowEngine: ShowEngineInput {
    
    private var showTimer: Timer?
    private var imageSize: ImageSize
    private var imageCache: [ShowEngineModel]
    private var output: ShowEngineOutput
    private var isEnabled = false
        
    public init(output: ShowEngineOutput, imageSize: ImageSize = ImageSize.full) {
        self.output = output
        self.imageSize = imageSize
        self.imageCache = []
    }
    
    // MARK: - ShowEngineInput protocol
    public func start() {
        isEnabled = true
        run()
    }
    
    public func stop() {
        isEnabled = false
        stopTimer()
    }
    
    // MARK: - Show Engine Run Loop
    private func run() {
        guard isEnabled else { return }
        
        getNextImage() { [weak self] in
            if var model = $0 {
                self?.loadImage(model: model) { [weak self] in
                    if let imageData = $0 {
                        model.imageData = imageData
                        print("Image loaded & ready for display: \(String(describing: model.imageData ?? nil))")
                        self?.output.imageLoadSuccess(data: model)
                        
                        self?.showTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { [weak self] timer in
                            self?.run()
                        })
                        
                    } else {
                        print("Couldn't load image")
                        self?.stop()
                        self?.output.imageLoadFailure()
                    }
                }
            } else {
                print("Couldn't load data")
                self?.stop()
                self?.output.imageLoadFailure()
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

    // MARK: - Data & Image Load
    private func loadData(completion: @escaping ([ShowEngineModel]?) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(Keys().unsplashAccessKey)"]
        Alamofire.request("https://api.unsplash.com/photos/random?count=10", headers: headers).responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode([ShowEngineModel].self, from: response.data!)
                print("Data loaded, image count: \(result.count)")
                completion(result)
            } catch {
                completion(nil)
            }
        }
    }
    
    private func loadImage(model: ShowEngineModel, completion: @escaping (Data?) -> Void) {
        if let imageURL = getImageURL(urls: model.images) {
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
    private func stopTimer() {
        if showTimer != nil {
            showTimer?.invalidate()
        }
    }
    
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
