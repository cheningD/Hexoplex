//
//  SwiftSha.swift
//  Hexoplex
//
//  Created by Chening Duker on 11/16/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import Foundation

extension String {
    func fuckCryptoSwiftsha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
}