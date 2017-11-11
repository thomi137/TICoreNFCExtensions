//
//  TINFCNDEFTypeFactory.swift
//  Nimble
//
//  Created by Thomas Prosser on 11.11.17.
//

import Foundation
import CoreNFC

class TINFCNDEFTypeFactory {

    static func parsedPayload(typeNameFormat: NFCTypeNameFormat, subtype: String, payload: Data) -> TINFCNDEFType?{
    
        switch (typeNameFormat, subtype){
        case (.absoluteURI, _):
            return nil
        case (.empty, _):
            return nil
        case (.media, _):
            return NFCNDEFMimeType(payload: payload)
        case (.nfcExternal, _):
            return nil
        case (.nfcWellKnown, let typeString) where typeString == "T":
            return NFCNDEFText(payload: payload)
        case (.nfcWellKnown, let typeString) where typeString == "U":
            return NFCNDEFUri(payload: payload)
        case (.unchanged, _):
            return nil
        case (.unknown, _):
            return nil
        default: ()
            return nil
        }
    }
}
