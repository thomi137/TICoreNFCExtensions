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
    
    public var firstByte: UInt8 {
        
        guard let firstByte = self.payload.first else { return 0x00 }
        return firstByte
        
    }
    
   public var parsedPayload: NDEFRTDType{
        
        switch (self.typeNameFormat, self.typeString){
        case (.absoluteURI, _):
            return .Unknown
        case (.empty, _):
            return .Unknown
        case (.media, _):
            return .M(parsedPayload: NFCNDEFMimeType(payload: self.payload))
        case (.nfcExternal, _):
            return .Unknown
        case (.nfcWellKnown, let typeString) where typeString == "T":
            return .T(parsedPayload: NFCNDEFText(statusByte: firstByte, payload: self.payload.suffix(from: 1)))
        case (.nfcWellKnown, let typeString) where typeString == "U":
            return .U(parsedPayload: NFCNDEFUri(payload: payload))
        case (.unchanged, _):
            return .Unknown
        case (.unknown, _):
            return .Unknown
        default: ()
        return .Unknown
        }
        
    }
}

public enum NDEFRTDType{
    
    case U(parsedPayload: NFCNDEFUri)
    case T(parsedPayload: NFCNDEFText)
    case M(parsedPayload: NFCNDEFMimeType)
    case Unknown
    
}

public enum WellKnownNDEFURI: UInt8 {
    
    case Full           = 0x00
    case HttpWww        = 0x01
    case HttpsWww       = 0x02
    case Http           = 0x03
    case Https          = 0x04
    case Tel            = 0x05
    case Mailto         = 0x06
    case AnonFtp        = 0x07
    case FtpFtp         = 0x08
    case Ftps           = 0x09
    case Sftp           = 0x0A
    case Smb            = 0x0B
    case Nfs            = 0x0C
    case Ftp            = 0x0D
    case Dav            = 0x0E
    case News           = 0x0F
    case Telnet         = 0x10
    case Imap           = 0x11
    case Rtsp           = 0x12
    case Urn            = 0x13
    case Pop            = 0x14
    case Sip            = 0x15
    case Sips           = 0x16
    case Tftp           = 0x17
    case Btspp          = 0x18
    case Btl2cap        = 0x19
    case Btgoep         = 0x1A
    case Tcpobex        = 0x1B
    case Irdaobex       = 0x1C
    case File           = 0x1D
    case UrnEpcId       = 0x1E
    case UrnEpcTag      = 0x1F
    case UrnEpcPat      = 0x20
    case UrnEpcRaw      = 0x21
    case UrnEpc         = 0x22
    case UrnNfc         = 0x23
    
    var uriPrefix: String {
        switch self {
        case .Full:         return ""
        case .HttpWww:      return "http://www."
        case .HttpsWww:     return "https://www."
        case .Http:         return "http://"
        case .Https:        return "https://"
        case .Tel:          return "tel:"
        case .Mailto:       return "mailto:"
        case .AnonFtp:      return "ftp://anonymous:anonymous@"
        case .FtpFtp:       return "ftp://ftp."
        case .Ftps:         return "ftps://"
        case .Sftp:         return "sftp://"
        case .Smb:          return "smb://"
        case .Nfs:          return "nfs://"
        case .Ftp:          return "ftp://"
        case .Dav:          return "dav://"
        case .News:         return "news:"
        case .Telnet:       return "telnet://"
        case .Imap:         return "imap:"
        case .Rtsp:         return "rtsp://"
        case .Urn:          return "urn:"
        case .Pop:          return "pop:"
        case .Sip:          return "sip:"
        case .Sips:         return "sips:"
        case .Tftp:         return "tftp:"
        case .Btspp:        return "btspp://"
        case .Btl2cap:      return "btl2cap://"
        case .Btgoep:       return "btgoep://"
        case .Tcpobex:      return "tcpobex://"
        case .Irdaobex:     return "iradobex://"
        case .File:         return "file://"
        case .UrnEpcId:     return "urn:epc:id:"
        case .UrnEpcTag:    return "urn:epc:tag:"
        case .UrnEpcPat:    return "urn:epc:pat:"
        case .UrnEpcRaw:    return "urn:epc:raw:"
        case .UrnEpc:       return "urn:epc:"
        case .UrnNfc:       return "urn:nfc:"
        }
        
    }
    
}

