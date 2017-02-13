//
//  String.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import UIKit

extension String: Error { }

extension String {

    func md5() -> Data? {
        guard let messageData = data(using: .utf8) else {
            return nil
        }

        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData
    }

    func md5() -> String? {
        let data: Data? = md5()
        return data?.map { String(format: "%02hhx", $0) }.joined()
    }

    func attributedStringFromHtml() -> NSAttributedString? {
        do {
            if let data = self.data(using: .utf8, allowLossyConversion: true) {
                return try NSAttributedString(
                    data: data,
                    options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                    documentAttributes: nil
                )
            }
        } catch { }

        return nil
    }

}
