//
//  CryptoNews.swift
//  CryptoCoinsNews
//
//  Created by Alaattin Bedir on 17.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import ObjectMapper

class Articles: Mappable {
    
    var message: String?
    var timestamp: Int32?
    var nickname: String?
    var avatarUrl: String?
    var type:UInt8 = 0
    
    init(message: String, timestamp: Int32, nickname: String, avatarUrl: String, type:UInt8) {
        self.message = message
        self.timestamp = timestamp
        self.nickname = nickname
        self.avatarUrl = avatarUrl
        self.type = type
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        timestamp <- map["timestamp"]
        nickname <- map["nickname"]
        avatarUrl <- map["avatarUrl"]
    }
    
    
}
