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
//                for index in 0...dictionaries.count{
//                    print(index)
//                }
//                for user in dictionaries {
//                    if let name = user["name"] {
//                        print("name of user is : \(name)")
//                    }
//                    guard let name = user["name"] else {
//                        return
//                    }
//                    print(name)
//                }
//                print(dictionaries)
            case .failure(let error):
                print("error")
                failure(error)
                break
                //            case .success(let data):
                //                print(data)
                //
                //            case .failure(let error):
                //                print(error)
            }
        }
    }
}
