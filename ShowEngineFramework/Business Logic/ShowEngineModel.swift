// 

import Foundation

public struct ShowEngineModel: Codable {
    public let imageDescription: String?
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
        case imageDescription = "description"
        case likes = "likes"
        case user = "user"
    }
}

extension ShowEngineModel: CustomStringConvertible {
    
    public var description: String {
        return """
        Image: \(imageDescription ?? "")
        Likes: \(likes ?? 0)
        Photographer: \(user.name ?? "")
        Photographer's Location: \(user.location ?? "")
        Photographer's Bio: \(user.bio ?? "")
        """
    }
}
