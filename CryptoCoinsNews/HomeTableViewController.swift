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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get messages from service
        ArticlesService.sharedInstance.getArticles(completion: { (articles) in
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

//class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
//    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
//        return .disableEvaluation
//    }
//    public init() {
//        super.init(policies: [:])
//    }
//}



