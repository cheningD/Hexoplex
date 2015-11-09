//
//  HexoskinInterface.swift
//  Hexoplex
//
//  Created by Chening Duker on 11/1/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import Foundation
import CryptoSwift

class HexoskinAPIRequest {
    //Member variables
    private var username:String
    private var password:String
    private var url = ""
    private let privateKey = "dODqtRuAQdyvUUS0gEbJUMssx0WPad"
    
    private var headers = [
        "authorization": " Basic XXX",
        "x-hexotimestamp": "",
        "x-hexoapikey": "7ojfFuB1S7222WcbdxhwNQqfUIIdHZ",
        "x-hexoapisignature": "",
        "cache-control": "no-cache",
        "postman-token": "197a8b89-71e0-54a3-0f5e-65ad029095d9"
    ]
    
    
    //Constructor
    init(username:String, password:String){
        self.username = username
        self.password = password
    }
    
    private func base64Encode(plainString:String)->String {
        let plainData = (plainString as
            NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        print("DEBUG: HexoskinAPIUser base64 encode: " + plainString + " --> " + String(base64String))
        return String(base64String)
    }
    
    private func base64Decode( base64String:String)->String {
        let decodedData = NSData(base64EncodedString: base64String, options:NSDataBase64DecodingOptions(rawValue: 0))
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        print("DEBUG: HexoskinAPIUser base64 decode: " + base64String + " --> " + String(decodedString))
    return String(decodedString);
    }
    
    private func createHeaders(){
        var basicAuth = username + ":" + password
        basicAuth = base64Encode(basicAuth)
        self.headers["authorization"] = "Basic " + basicAuth
        self.headers["x-hexotimestamp"] = "1447094785" //String(NSDate().timeIntervalSince1970)
        //Signature is the SHA of Private Key, Timestamp, Url.
        let signature = self.privateKey + self.headers["x-hexotimestamp"]! + self.url
        self.headers["x-hexoapisignature"] = signature.sha1()
        print("DEBUG: HexoskinAPIUser SHA: " +  signature + " --> ")
        print(self.headers["x-hexoapisignature"])
    }
    
    private func makeAPIRequest(){
        var request = NSMutableURLRequest(URL: NSURL(string: self.url)!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = self.headers
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("DEBUG: HexoskinAPIUser HTTP RESPONSE ERROR: ")
                print(error)
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                print("DEBUG: HexoskinAPIUser HTTP RESPONSE: " )
                print(httpResponse)
                print("headers:")
                print(httpResponse?.allHeaderFields)
                print("description")
                print(httpResponse?.description)
            }
        })
        
        dataTask.resume()
    }
    
    
    internal func getUserInfo() {
        self.url = "https://api.hexoskin.com/api/user/"
        createHeaders()
        print("DEBUG: HexoskinAPIUser HEADERS: ")
        print(self.headers)
        makeAPIRequest()
    }
    
}
