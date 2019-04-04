//
//  ShowEngine.swift
//  ShowEngineFramework
//
//  Created by Martin Legowiecki on 4/3/19.
//

import Foundation
import Alamofire

public struct ShowEngineModel: Codable {
    public let description: String?
    public let images: Images
    public let likes: Int?
    public let user: User
    
    public struct Images: Codable {
        public let raw: String?
        public let full: String?
        public let regular: String?
        public let small: String?
        public let thumb: String?
    }
    
    public struct User: Codable {
        public let name: String?
        public let bio: String?
        public let location: String?
        public let profileImages: UserProfileImages
        
        public struct UserProfileImages: Codable {
            public let small: String?
            public let medium: String?
            public let large: String?
        }
        
        public enum CodingKeys: String, CodingKey {
            case name = "name"
            case bio = "bio"
            case location = "location"
            case profileImages = "profile_image"
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case images = "urls"
        case description = "description"
        case likes = "likes"
        case user = "user"
    }
}

public class ShowEngine {
    
    public init(completion: @escaping (String?) -> Void) {
        
        let headers: HTTPHeaders = ["Authorization": "Client-ID 9ddafc1631e4b9d632465d3fe49a1eee0e6e781bd206644e213713dc78995317"]
        
        Alamofire.request("https://api.unsplash.com/photos/random", headers: headers).responseJSON { response in
            do {
                let result = try JSONDecoder.init().decode(ShowEngineModel.self, from: response.data!)
                print(result.images.raw ?? "")
                print(result.user.name ?? "")
                completion(result.description)
            } catch {
                print("<- something aint right \(error)")
                completion(nil)
            }
        }
    }
}
