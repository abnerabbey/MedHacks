//
//  URLManager.swift
//  MedHacks
//
//  Created by Abner Castro on 9/8/18.
//  Copyright © 2018 Abner Castro. All rights reserved.
//

import Foundation

class URLManager {
    
    let username = "dba8d930-8c83-4258-a820-2002f2039593"
    let password = "mHr8xfBHiflP"
    let url = "https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2017-09-21"
    
    func performAnalyzeText(text: String, success: @escaping([String: Any])->Void, failure: @escaping(Error?)->Void) {
        let authString = username + ":" + password
        let authData = authString.data(using: String.Encoding.ascii)
        let authValue = "Basic " + authData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization" : authValue]
        let session = URLSession(configuration: configuration)
        
        let parameters = ["text":text]
        do {
            guard let url = URL(string: url) else { return }
            let dataSend = try JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest(url: url)
            request.httpBody = dataSend
            request.httpMethod = "POST"
            request.setValue("dba8d930-8c83-4258-a820-2002f2039593", forHTTPHeaderField: "user")
            request.setValue("mHr8xfBHiflP", forHTTPHeaderField: "pass")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
                        success(json)
                    } catch {
                    }
                }
                if let error = error {
                    failure(error)
                }
            }
            task.resume()
        }catch {
            failure(error)
        }
        
    }
}
