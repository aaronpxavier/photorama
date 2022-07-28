//
//  Photo.swift
//  Photorama
//
//  Created by ladmin on 7/27/22.
//

import Foundation





class Photo: Codable {
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
 

}
