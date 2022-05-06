//
//  APIRequirement.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

enum HTTPMethod:String {
    case get
    case post
    case put
}


protocol APIRequirement {
    
    static var baseURL:String {get}
    var apiHeader:[String:String] {get}
    var apiPath:String {get}
    var apiMethod:String {get}
    
    @discardableResult func request<T:Decodable>(objectType:T.Type, method:HTTPMethod, urlParameters:String?, parameters:[String:Any]?, complition:((_ object:T?, _ error:Error?)->Void)?) -> URLSessionDataTask?
    
}

extension APIRequirement {
    
    @discardableResult func request<T:Decodable>(objectType:T.Type, method:HTTPMethod = .get, urlParameters:String? = nil, parameters:[String:Any]? = nil, complition:((_ object:T?, _ error:Error?)->Void)?) -> URLSessionDataTask? {
        
        var urlString = apiPath + apiMethod
        
        if method == .get, let urlparam = urlParameters {
            urlString += "?\(urlparam)"
        }
        
        guard let url = URLComponents(string: urlString) else {
            return nil
        }
        
        
        var urlRequest = URLRequest(url: url.url!)
        urlRequest.httpMethod = method.rawValue
        
        for (key,value) in self.apiHeader {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let param = parameters, param.count > 0, method != .get {
            let jsonData = try? JSONSerialization.data(withJSONObject: param)
            urlRequest.httpBody = jsonData
        }
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if let datas = data, let json = try? JSONSerialization.jsonObject(with: datas, options: []) {
                    print(json)
                }
                if !(200...299 ~= httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        complition?(nil,error)
                    }
                    
                } else if let datas = data, let object = try? JSONDecoder().decode(T.self, from: datas) {
                    DispatchQueue.main.async {
                        complition?(object,nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    complition?(nil,error)
                }
            }
        }
        
        urlSession.resume()
        
        return urlSession
        
    }
    
}
