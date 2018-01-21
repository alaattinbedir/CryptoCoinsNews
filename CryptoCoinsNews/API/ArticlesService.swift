//
//  ArticlesService.swift
//  CryptoCoinsNews
//
//  Created by Alaattin Bedir on 17.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import Alamofire
import SwiftyJSON
import ObjectMapper


public class ArticlesService {
    static let sharedInstance = ArticlesService()
    private var manager: SessionManager
    
    
    private init() {
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        
        self.manager = manager        
    }
    
    func getArticles(completion:@escaping (Array<Articles>) -> Void, failure:@escaping (Int, String) -> Void) -> Void{
        let url: String = "https://newsapi.org/v2/top-headlines?sources=crypto-coins-news&apiKey=3c5a70f49873451c81967f374d1b1db9"
        
        self.manager.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                // get JSON return value and check its format
                guard let responseJSON = response.result.value as? [String: Any] else {
                    failure(0,"Error reading response")
                    return
                }
                
                // Convert to json
                let json = JSON(responseJSON)
                
                // Get json array  from data
                let array = json["articles"].arrayObject
                
                // Map json array to Array<Message> object
                guard let articles:[Articles] = Mapper<Articles>().mapArray(JSONObject: array) else {
                    failure(0,"Error mapping response")
                    return
                }
                
                // Send to array to calling controllers
                completion(articles)
                
            case .failure(let error):
                failure(0,"Error \(error)")
            }
        }
    }
    
}

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}

