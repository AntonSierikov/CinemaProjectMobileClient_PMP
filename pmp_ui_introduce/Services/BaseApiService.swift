//
//  BaseApiService.swift
//  pmp_ui_introduce
//
//  Created by student on 11/29/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation
import UIKit;

class BaseApiService {

    private let session: URLSession;
    
    public var token: String;
    public var apiServiceUrl: String;
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral);
        token = "915ba5ac74f317e1048dfb39d3ebcdbd";
        apiServiceUrl = "https://api.themoviedb.org/3/";
    }
    
    internal func loadData<T: Decodable>(url: URL, with completionBlock: @escaping (((T) -> Void)), errorBlock: ((String) -> Void)?) -> Void {
        let changedUrl = addToken(url: url);
        let task = session.dataTask(with: changedUrl)
        {
            (data, response, error) in
            guard error == nil else {
                let error = error?.localizedDescription ?? "Unknown error";
                errorBlock?(error);
                return;
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data else {
                    errorBlock?("Bad response");
                    return;
            }
            
            let responseData = try? JSONDecoder().decode(T.self, from: data);
            
            guard let returnValue = responseData else {
                errorBlock?("Unknown data format")
                return;
            }
            
            completionBlock(returnValue);
        }
        
        task.resume();
    }
    
    private func addToken(url: URL) -> URL {
        var c = URLComponents(string: url.absoluteString)!;
        
        if (c.queryItems == nil || c.queryItems?.count == 0) {
            c.queryItems = [];
        }
        
        c.queryItems!.append(URLQueryItem(name: "api_key", value: token));
        
        return c.url!;
    }
}
