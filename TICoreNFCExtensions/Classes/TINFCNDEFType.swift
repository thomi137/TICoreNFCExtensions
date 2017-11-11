//
//  ITNFCNDEFType.swift
//  Nimble
//
//  Created by Thomas Prosser on 11.11.17.
//

import Foundation

public protocol TINFCNDEFType : CustomStringConvertible {
    var encodedPayload: String? { get }
    var locale: String? { get }
    var encoding: String.Encoding? { get }
}

public struct NFCNDEFText: TINFCNDEFType {
    
    var payload: Data
    
    var statusByte: UInt8 {
        guard let retVal = payload.first else { return 0x00 }
        return retVal
    }
    
    public var encoding: String.Encoding? {
        
        let encodingBit = statusByte & (1 << 7)
        return Optional(encodingBit == 0 ? .utf8 : .utf16)
        
    }
    
    public var localeLength: Int {
        
        return Int(statusByte & 0x3F)
        
    }
    
    public var locale: String? {
        
        let localeBytes = payload.prefix(through: localeLength)
        return String(data: localeBytes, encoding: .ascii)
        
    }
    
    public var encodedPayload: String? {
        // Go past status bytes and locale bytes.
        let textBytes = payload.suffix(from: localeLength + 1)
        return String(data: textBytes, encoding: encoding!)
    }
    
    public var description: String{
        return "Text type. locale: \(locale ?? "not found"), encoding: \(String(describing: encoding)), text: \(encodedPayload ?? "No payload found")"
    }
}


public struct NFCNDEFUri: TINFCNDEFType {

    var payload: Data
    
    public var uriType: WellKnownNFCNDEFUriType {
        guard let firstByte = payload.first else { return WellKnownNFCNDEFUriType(rawValue: 0x00)! }
        return WellKnownNFCNDEFUriType(rawValue: firstByte)!
    }
    
    public var encodedPayload: String? {
        guard let uriAddress = String(data: payload.suffix(from: 1), encoding: .utf8) else { return "" }
        return uriType.uriPrefix + uriAddress
    }
    
    public var locale: String?{
        return nil
    }
    
    // All URI Types are encoded in utf-8
    public var encoding: String.Encoding? {
        return .utf8
    }
    
    public var description: String {
        
        return "URI type. URI: \(self.uriType.uriPrefix) + \(encodedPayload ?? "Invalid path")"
        
    }
    
}

// TODO. This struct does not handle values like image/jpeg and other binaries.
public struct NFCNDEFMimeType: TINFCNDEFType {
    
    public var locale: String? {
        return nil
    }
    
    public var encoding: String.Encoding?{
        return nil
    }
    
    var payload: Data
    
    public var encodedPayload: String? {
        return String(data: payload, encoding: .utf8)
    }
    
    public var description: String {
        return "Media type. Payload: \(encodedPayload ?? "No Payload")"
    }
}

