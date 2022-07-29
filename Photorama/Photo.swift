//
//  Photo.swift
//  Photorama
//
//  Created by ladmin on 7/27/22.
//

import Foundation





class Photo: Codable, Equatable {
    let title:String
    let photoID: String
    let remoteURL: URL?
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
 

}
