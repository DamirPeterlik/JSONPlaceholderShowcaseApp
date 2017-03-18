//
//  APIService.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Alamofire
import Unbox

class APIService {
    
    static let sharedInstance = APIService()
    
    func loadData(withSuccess success: @escaping ([UnboxableDictionary]) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(Router.Users).responseJSON { (response) in
            
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [UnboxableDictionary] else {
                    return success([])
                }
                success(dictionaries)
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    func postData(newPost: Dictionary<String, Any>, withSuccess success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(Router.MakeNewPost(parameters: newPost)).responseJSON { (response) in
            print(response)
            
            switch response.result {
            case .success:
                success("response from success")
            case .failure(let error):
                failure(error)
            }
        }
    }
}
