//
//  NFCNDEFPayload+Parsing.swift
//  Pods
//
//  Created by Thomas Prosser on 10.11.17.
//

import Foundation
import CoreNFC

@available(iOS 11.0, *)
extension NFCNDEFPayload {
    
   public var typeString: String {
        guard let retVal = String(data: self.type, encoding: .utf8) else { return "" }
        return retVal
    }
    
    public var parsedPayload: TINFCNDEFType{
        return TINFCNDEFTypeFactory.parsedPayload(typeNameFormat: self.typeNameFormat, subtype: typeString, payload: self.payload)!
    }
}
