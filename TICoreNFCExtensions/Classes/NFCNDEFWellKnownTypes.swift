//
//  NFCNDEFWellKnownTypes.swift
//  Pods
//
//  Created by Thomas Prosser on 10.11.17.
//

import Foundation

public protocol NFCNDEFWellKnownType : CustomStringConvertible {
    
    func getText() -> String?
    
}

public struct NFCNDEFText: NFCNDEFWellKnownType {

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
    
    public var description: String{
        return "locale: \(locale), encoding: \(encoding)"
    }
}

public struct NFCNDEFUri: NFCNDEFWellKnownType {
    
    var payload: Data
    
   public var uriType: WellKnownNDEFURI {
        guard let firstByte = payload.first else { return WellKnownNDEFURI(rawValue: 0x00)! }
        return WellKnownNDEFURI(rawValue: firstByte)!
    }
    
   public func getText() -> String? {
        
        guard let uriAddress = String(data: payload.suffix(from: 1), encoding: .utf8) else { return "" }
        return uriType.uriPrefix + uriAddress
        
    }
    
    public var description: String {
        
        return "prefix: \(self.uriType.uriPrefix)"
        
    }

    
}
