//
//  NFCNDEFPayloadMimeTypes.swift
//  Nimble
//
//  Created by Thomas Prosser on 10.11.17.
//

import Foundation

public struct NFCNDEFMimeType {
    
    var payload: Data
    
    public func getText() -> String? {
        return String(data: payload, encoding: .utf8)
    }
    
}
