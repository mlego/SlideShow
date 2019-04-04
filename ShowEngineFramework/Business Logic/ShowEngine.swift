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
    
    public init(imageSize: ImageSize) {
        self.imageSize = imageSize
    }
    
    // MARK - show timer
    
    public func start() {
        showTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { timer in
            print("fired")
        })
        showTimer?.fire()
    }
    
    public func stop() {
        stopTimer()
    }
    
    public func stopTimer() {
        if showTimer != nil {
            showTimer?.invalidate()
        }
    }
    
    // MARK - get data from Unsplash
    public func getData() {
        let headers: HTTPHeaders = ["Authorization": "Client-ID 9ddafc1631e4b9d632465d3fe49a1eee0e6e781bd206644e213713dc78995317"]

        Alamofire.request("https://api.unsplash.com/photos/random", headers: headers).responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode(ShowEngineModel.self, from: response.data!)
                print(result.images.raw ?? "")
                print(result.user.name ?? "")
            } catch {
                print("<- something aint right \(error)")
            }
        }
    }
    
    deinit {
        stopTimer()
    }
}
