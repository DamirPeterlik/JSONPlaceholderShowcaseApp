//
//  Router.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    case Users
    case Comments
    case Posts
    case Photos
    case MakeNewPost(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .Users, .Comments, .Posts, .Photos:
            return .get
        case .MakeNewPost:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .Users:
            return "/users"
        case .Comments:
            return "/comments"
        case .Posts:
            return "/posts"
        case .Photos:
            return "/photos"
        case .MakeNewPost:
            return "/posts/1"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .Users, .Comments, .Posts, .Photos:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .MakeNewPost(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with:parameters)
        }
        return urlRequest
    }
}
