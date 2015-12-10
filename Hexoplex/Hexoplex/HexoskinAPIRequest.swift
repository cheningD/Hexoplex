//
//  HexoskinAPIRequest.swift
//  Hexoplex
//
//  Created by Chening Duker on 11/1/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import Foundation
import Alamofire


class HexoskinAPIRequest : NSObject {
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

    private struct jsonHexoskinDatatype {
        let heartRate:Int = 19
        let breathingRate:Int = 33
        let minVentialtion:Int = 36
        let activity:Int = 49
    }
    private let hxDatatype = jsonHexoskinDatatype()

    private var realtimeTimer:NSTimer? = nil
    private var realtimeRecordId:Int = 0
    private var realtimeHeartRateGaugueUpdateFunc: (Int)->Void = {_ in }
    private var realtimeLungRateGaugueUpdateFunc: (Int)->Void = {_ in }
    private let timerInterval:Double = 0.5 // refresh data
    //Constructor
    init(username:String, password:String){
        self.username = username
        self.password = password
    }

    private func base64Encode(plainString:String)->String {
        let plainData = (plainString as
            NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        //print("DEBUG: HexoskinAPIUser base64 encode: " + plainString + " --> " + String(base64String))
        return String(base64String)
    }

    private func base64Decode( base64String:String)->String {
        let decodedData = NSData(base64EncodedString: base64String, options:NSDataBase64DecodingOptions(rawValue: 0))
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        //print("DEBUG: HexoskinAPIUser base64 decode: " + base64String + " --> " + String(decodedString))
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

    internal func getUserInfo( completion: (result: NSDictionary)->Void) {
        self.url = "https://api.hexoskin.com/api/user/"
        self.createHeaders()
        //Get user info
        //REQUEST 1
        Alamofire.request(.GET, self.url, headers: self.headers)
            .responseJSON { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                let users = JSON as! NSDictionary
                if (users["errors"] != nil) {
                    print("Error retrieving user data")
                    let userInfoDict: [String:String] =
                    [
                        "error" : "The email and password combination that you used to login to your Hexoskin account is invalid. If you have changed your password please logout then log in with the new password. Email: (\(self.username)) Password (hidden)",
                    ]
                    completion(result: userInfoDict)
                    return
                }
                let user1:NSDictionary = users["objects"]![0] as! NSDictionary
                print(user1)

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

            case .Failure(let error):
                print("getUserInfo() REQUEST failed with error: \(error)")
            }
        }

    }

    //Reuests  specific record timestamp to return realtime data
    func getRealtimeUpdate(sender:AnyObject) {
        Alamofire.request(.GET, self.url, headers: self.headers)
            .responseJSON { response in switch response.result {
            case .Success(let JSON3):
                var err:NSDictionary?
                if (JSON3[0] == nil) {
                    err = JSON3["errors"]! as! NSDictionary!
                    print(err!["__all__"])
                    self.realtimeHeartRateGaugueUpdateFunc(0)
                    self.realtimeLungRateGaugueUpdateFunc(0)
                    return
                }

                let bioInfo = JSON3[0]["data"]! as! NSDictionary!
                let heartDataArr = bioInfo["19"]! as! NSArray
                let lungDataArr = bioInfo["33"]! as! NSArray
                let lastIndexHeart:Int = -1 + heartDataArr.count
                heartDataArr[lastIndexHeart]
                let lastIndexLung:Int = -1 + lungDataArr.count
                lungDataArr[lastIndexLung]
                print("lastIndexHeart: \(lastIndexHeart) Value: \(heartDataArr[lastIndexHeart])")
                print("lastIndexLung: \(lastIndexLung) Value: \(lungDataArr[lastIndexLung])")
                let heartRateNow:Int = heartDataArr[lastIndexHeart][1] as! Int
                let lungRateNow:Int = lungDataArr[lastIndexLung][1] as! Int
                //update gauge
                self.realtimeHeartRateGaugueUpdateFunc(heartRateNow)
                self.realtimeLungRateGaugueUpdateFunc(lungRateNow)
                //Prepare the next request
                var newStartTime = heartDataArr[lastIndexHeart][0] as! Int
                newStartTime++
                let newEndTime:Int = newStartTime + ( 24 * 60 * 60 * 256)
                self.url = "https://api.hexoskin.com/api/data/?record=\(self.realtimeRecordId)"
                    + "&datatype=\(self.hxDatatype.heartRate),"
                    + "\(self.hxDatatype.breathingRate)"
                    + "&start=\(newStartTime)"
                    + "&end=\(newEndTime)"
                self.createHeaders()

                self.realtimeTimer = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: "getRealtimeUpdate:", userInfo: nil, repeats: false)

            case .Failure(let error):
                print("getRealtimeUpdate() REQUEST failed with error: \(error)")
                }
        }
    }

    internal func getRealtimeData( heartCompletion: (rate: Int)->Void, lungCompletion: (rate: Int)->Void ) {
        self.realtimeHeartRateGaugueUpdateFunc = heartCompletion
        self.realtimeLungRateGaugueUpdateFunc = lungCompletion
        self.url = "https://api.hexoskin.com/api/user/"
        self.createHeaders()
        //Get user info
        //REQUEST 1
        Alamofire.request(.GET, self.url, headers: self.headers)
            .responseJSON { response in switch response.result {
            case .Success(let JSON):
                //print("Success with JSON: \(JSON)")
                let userId0 = JSON as! NSDictionary
                let userId_:Int = userId0["objects"]![0]["id"] as! Int
                let userId:String = String(userId_)
                print(userId)

                self.url = "https://api.hexoskin.com/api/record/?user=\(userId)"
                self.createHeaders()

                //Request2
                Alamofire.request(.GET, self.url, headers: self.headers)
                    .responseJSON { response in switch response.result {
                    case .Success(let JSON):
                        //print("Success with JSON: \(JSON)")
                        let res2 = JSON as! NSDictionary
                        let status:String = res2["objects"]![0]["status"] as! String
                        self.realtimeRecordId = res2["objects"]![0]["id"] as! Int
                        let startTime:Int = res2["objects"]![0]["start"] as! Int
                        if (status == "realtime") {
                            print( "realtime data available! status = \(status)")
                            let endTime:Int = startTime + ( 24 * 60 * 60 * 256)

                            // Get actual realtime data

                            self.url = "https://api.hexoskin.com/api/data/?record=\(self.realtimeRecordId)"
                            + "&datatype=\(self.hxDatatype.heartRate),\(self.hxDatatype.breathingRate)"
                            + "&start=\(startTime)"
                            + "&end=\(endTime)"
                            self.createHeaders()
                            // Initialize timer to get data
                            self.getRealtimeUpdate(self)
                            //self.realtimeTimer = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: "getRealtimeUpdate:", userInfo: nil, repeats: true)

                        }
                        else {
                            print( "no realtime data status = \(status)")
                            let endTime:Int = res2["objects"]![0]["end"] as! Int
                            self.url = "https://api.hexoskin.com/api/data/?record=\(self.realtimeRecordId)"
                                + "&datatype=\(self.hxDatatype.heartRate),\(self.hxDatatype.breathingRate)"
                                + "&start=\(startTime)"
                                + "&end=\(endTime)"
                            self.createHeaders()
                            //REQUEST (3.5 NOT INCLUDED IN FINAL APP)
                            Alamofire.request(.GET, self.url, headers: self.headers)
                                .responseJSON { response in switch response.result {
                                case .Success(let JSON4):
                                    print("Super Success with JSON: \(JSON4)")
                                case .Failure(let error):
                                    print("getRealtimeData() REQUEST 2 failed with error: \(error)")
                                    }
                            }

                        }


                    case .Failure(let error):
                         print("getRealtimeData() REQUEST 2 failed with error: \(error)")
                    }
                }

            case .Failure(let error):
                print("getRealtimeData() REQUEST 1 failed with error: \(error)")
            }

        }

    }
}
