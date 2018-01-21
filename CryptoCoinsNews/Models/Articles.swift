//
//  Articles.swift
//  CryptoCoinsNews
//
//  Created by Alaattin Bedir on 17.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import ObjectMapper

class Articles: Mappable {
    
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Int32?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
    }
    
    
}
