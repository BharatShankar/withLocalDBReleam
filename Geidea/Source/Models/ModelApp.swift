//
//  ModelApp.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import Foundation
import RealmSwift

class ModelApp: Object, Decodable {
    
    @objc dynamic private(set) var artistId: String = ""
    @objc dynamic private(set) var artistName: String = ""
    @objc dynamic private(set) var artistUrl: String = ""
    @objc dynamic private(set) var artworkUrl100: String = ""
    @objc dynamic private(set) var copyright: String = ""
    @objc dynamic private(set) var id: String = ""
    @objc dynamic private(set) var kind: String = ""
    @objc dynamic private(set) var name: String = ""
    @objc dynamic private(set) var releaseDate: String = ""
    @objc dynamic private(set) var url: String = ""

    var genres : List<ModelGenre> = List<ModelGenre>()
    
    override class func primaryKey() -> String? {
        return ModelApp.CodingKeys.id.stringValue
    }
    
    /// Helpers
    
    var commaSeparatedGenersName: String {
        genres.map({ $0.name }).joined(separator: ", ")
    }
}


class ModelGenre: Object, Decodable {
    @objc dynamic private(set) var genreId: String = ""
    @objc dynamic private(set) var name: String = ""
    @objc dynamic private(set) var url: String = ""
}



