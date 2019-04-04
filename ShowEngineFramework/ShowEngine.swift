//
//  ShowEngine.swift
//  ShowEngineFramework
//
//  Created by Martin Legowiecki on 4/3/19.
//

import Foundation
import Alamofire

public struct ShowEngineModel: Codable {
    public let url: String
}

public class ShowEngine {
    
    public init(completion: @escaping (String?) -> Void) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode(ShowEngineModel.self, from: response.data!)
                completion(result.url)
            } catch {
                completion(nil)
            }
        }
    }
}
