//
//  APIService.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import AlamofireObjectMapper
import Alamofire
import Unbox

class APIService {
    
    static let sharedInstance = APIService()
    
    func loadUsersObjectMapper(withSuccess success: @escaping ([UserObjectMapper]) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(Router.Users).responseArray { (response: DataResponse<[UserObjectMapper]>) in
            
            switch response.result {
            case .success:
                guard let usersResponse = response.result.value else {
                    return success([])
                }
                var users: [UserObjectMapper] = []
                for user in usersResponse {
                    users.append(user)
                }
                success(users)
                
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    func loadUsers(withSuccess success: @escaping ([User]) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(Router.Users).responseJSON { (response) in
            
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [UnboxableDictionary] else {
                    return success([])
                }
                
                do {
                    let users: [User] = try unbox(dictionaries: dictionaries)
                    success(users)
                } catch {
                    failure(error)
                }
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    func postData(newPost: Dictionary<String, Any>, withSuccess success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(Router.MakeNewPost(parameters: newPost)).responseJSON { (response) in
            
            switch response.result {
            case .success:
                success("response from success")
            case .failure(let error):
                failure(error)
            }
        }
    }
}
