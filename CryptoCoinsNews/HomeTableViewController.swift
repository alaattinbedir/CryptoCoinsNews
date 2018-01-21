//
//  ViewController.swift
//  CryptoCoinsNews
//
//  Created by Alaattin Bedir on 17.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


class HomeTableViewController: UITableViewController {

    var articlesArray = [Articles]()
    
    private static var manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "time.org": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            "newsapi.org": .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
        override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
            return .disableEvaluation
        }
        public init() {
            super.init(policies: [:])
        }
    }
    
    func getArticles(completion:@escaping (Array<Articles>) -> Void, failure:@escaping (Int, String) -> Void) -> Void{
        let url: String = "https://newsapi.org/v2/top-headlines?sources=crypto-coins-news&apiKey=3c5a70f49873451c81967f374d1b1db"
        HomeTableViewController.manager.request(url).validate(statusCode: 200..<300).responseJSON { response in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get messages from service
        self.getArticles(completion: { (articles) in
            self.articlesArray = articles
            if self.self.articlesArray.count > 0 {
//                self.tableView.reloadData()
            }
        }) { (code, error) in
            self.showMessage(message: error)
        }
        
    }

    fileprivate func showMessage(message : String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

