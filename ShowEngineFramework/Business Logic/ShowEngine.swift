//
//  ShowEngine.swift
//  ShowEngineFramework
//
//  Created by Martin Legowiecki on 4/3/19.
//

import Foundation
import Alamofire

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
    private var imageData: [ShowEngineModel]
    
    public init(imageSize: ImageSize) {
        self.imageSize = imageSize
        self.imageData = []
    }
    
    // MARK: - Engine Timer
    public func start() {
        if imageData.isEmpty {
            getData() { [weak self] in
                if let result = $0 {
                    self?.imageData = result
                    self?.start()
                }
            }
        } else {
            showTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] timer in
                if let image = self?.imageData.popLast() {
                    print("will display", "\(image)")
                }
            })
            showTimer?.fire()
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
    
    // MARK: - Data Load
    public func getData(completion: @escaping ([ShowEngineModel]?) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Client-ID 9ddafc1631e4b9d632465d3fe49a1eee0e6e781bd206644e213713dc78995317"]

        Alamofire.request("https://api.unsplash.com/photos/random", headers: headers).responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode(ShowEngineModel.self, from: response.data!)
                print(result.images.raw ?? "")
                print(result.user.name ?? "")
                completion([result])
            } catch {
                print("<- something aint right \(error)")
                completion(nil)
            }
        }
    }
    
    deinit {
        stopTimer()
    }
}
