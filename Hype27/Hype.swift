//
//  Hype.swift
//  Hype27
//
//  Created by Albert Yu on 7/9/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Hype"
    fileprivate static let recordTextKey = "Text"
    fileprivate static let recordTimestampKey = "Timestamp"
}

class Hype {
    let hypeText: String
    let timeStamp: Date
    
    init(hypeText: String, timeStamp: Date) {
        self.hypeText = hypeText
        self.timeStamp = timeStamp
    }
}
    // Creating a hype from a record
extension Hype {
    convenience init? (ckRecord: CKRecord) {
        guard let hypeText = ckRecord[Constants.recordTextKey] as? String, let hypeTimestamp = ckRecord[Constants.recordTimestampKey] as? Date else {return nil}
        self.init(hypeText: hypeText, timeStamp: hypeTimestamp)
    }
}

    // Letting CKRecord initialize from a Hype object.
extension CKRecord {
    convenience init(hype: Hype) {
        self.init(recordType: Constants.recordTypeKey)
        self.setValue(hype.hypeText, forKey: Constants.recordTextKey)
        self.setValue(hype.timeStamp, forKey: Constants.recordTimestampKey)
    }
}


