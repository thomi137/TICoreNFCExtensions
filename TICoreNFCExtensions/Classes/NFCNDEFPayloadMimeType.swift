//
//  NFCNDEFPayloadMimeTypes.swift
//  Nimble
//
//  Created by Thomas Prosser on 10.11.17.
//

import Foundation

public struct NFCNDEFMimeType {
    
    var statusByte: UInt8
    var payload: Data
    
    public var encoding: String.Encoding {
        
        let encodingBit = statusByte & (1 << 7)
        return encodingBit == 0 ? .utf8 : .utf16
        
    }
    
    public var localeLength: Int {
        
        return Int(statusByte & 0x3F)
        
    }
    
    public var locale: String {
        
        let localeBytes = payload.prefix(through: localeLength)
        return String(data: localeBytes, encoding: .ascii)!
        
    }
    
    public func getText() -> String? {
        // Go past status bytes and locale bytes.
        let textBytes = payload.suffix(from: localeLength + 1)
        return String(data: textBytes, encoding: encoding)
    }
    
}
