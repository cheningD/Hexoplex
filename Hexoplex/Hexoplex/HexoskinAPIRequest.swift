//
//  HexoskinAPIRequest.swift
//  Hexoplex
//
//  Created by Chening Duker on 11/1/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import Foundation
import Alamofire


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
    
    //Variables that are created via API REQUESTS
    private var userId:String?
    
    //Constructor
    init(username:String, password:String){
        self.username = username
        self.password = password
        self.userId = nil
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
        self.headers["x-hexotimestamp"] = String(Int(NSDate().timeIntervalSince1970))
        //Signature is the SHA of Private Key, Timestamp, Url.
        let signature:String = self.privateKey + self.headers["x-hexotimestamp"]! + self.url        
        self.headers["x-hexoapisignature"] = signature.fuckCryptoSwiftsha1()
        //print("DEBUG: HexoskinAPIUser SHA: " +  signature + " --> ")
        //print(self.headers["x-hexoapisignature"])
    }
    
    private func makeAPIRequest( completion: (user1: NSDictionary)->Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: self.url)!,
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
                //let httpResponse = response as? NSHTTPURLResponse
                //print(httpResponse)
                //print("DEBUG: HexoskinAPIUser HTTP data: " )
                var json:NSDictionary?
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }
                catch {
                    print("DEBUG: Error in makeAPIRequest func. Cannot make json object from response")
                }
                let stuff = json!["objects"]
                let user1 = stuff?[0]! as! NSDictionary
                
                completion(user1: user1)
                //print(stuff!)
                //print(user1)
                //print(stuff![0]["email"])
                
                
                //let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print("Error could not parse JSON: '\(jsonStr)'")
                
            }
        })
        
        dataTask.resume()
    }
    
    
    internal func getUserInfo( completion: (result: NSDictionary)->Void) {
        self.url = "https://api.hexoskin.com/api/user/"
        createHeaders()
        print("DEBUG: HexoskinAPIUser HEADERS: ")
        print(self.headers)
        
        func completion1(user1: NSDictionary){
            self.userId = String(user1["id"]!)
            let userInfoDict: [String:String] =
            [
                "email" : String(user1["email"]!),
                "first_name" : String(user1["first_name"]!),
                "id" : String(user1["id"]!),
                "last_name" : String(user1["last_name"]!),
                "profile" : String(user1["profile"]!),
                "resource_uri" : String(user1["resource_uri"]!),
                "username" : String(user1["username"]!),
            ]
            completion(result: userInfoDict)
        }
        makeAPIRequest(completion1)
        
    }
    
}
