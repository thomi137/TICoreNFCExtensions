# TICoreNFCExtensions

[![CI Status](http://img.shields.io/travis/thomi137/TICoreNFCExtensions.svg?style=flat)](https://travis-ci.org/thomi137/TICoreNFCExtensions)
[![Version](https://img.shields.io/cocoapods/v/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)
[![License](https://img.shields.io/cocoapods/l/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)
[![Platform](https://img.shields.io/cocoapods/p/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)

## Motivation

As of iOS 11, Apple opened up their NFC hardware so developers can make their apps read NFC Tags that carry payloads compliant to the [NDEF](http://sweet.ua.pt/andre.zuquete/Aulas/IRFID/11-12/docs/NFC%20Data%20Exchange%20Format%20(NDEF).pdf) specification. When reading through the [CoreNFC](https://developer.apple.com/documentation/corenfc) docs however, it seems clear that this is a framework in its making (it does not allow writing, e.g., nor can you make your phone react to a tag when as would be the case with Android; you have to have a dedicated app).

## Usage

### How to enable NFC

First of all, there is a capability called **Near Field Communication Tag Reading** in your project file, which you should turn on. You can then set a string that pops up whenever you tell your app to scan a tag in your info.plist. The string to look for is `Privacy - NFC Scan Usage Description`.

### Starting an NFC Session

In the ViewController (or module) handling scanning, just `import CoreNFC` and you're ready. In a trial app, just make your View Controller a `NFCNDEFReaderSessionDelegate` and add the two methods coming with it. The thing is that whenever you want to scan a tag, you need to create a `NFCNDEFReaderSession` (have a look at the example project. It's basically how they do it in the docs. We suggest you trigger it via an UI interaction, since a modal will pop up telling you to touch the tag with your device. Have a look at the [docs](https://developer.apple.com/documentation/corenfc) for details of how to set this up.


in your `func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) -> ()`, you receive an array of `NFCNDEFMessage`s. The elements basically themselves contain arrays of `NFCNDEFPayload`s, which this pod extends (further wrapping planned... Hey! It's a beta and this is my weekend!). This pod basically adds an additional

```swift
public var parsedPayload: TINFCNDEFType
```

to the `NFCNDEFPayload` class. It is basically a representation of the payload according to it's NDEF Type Name Format. Again, see [here](http://sweet.ua.pt/andre.zuquete/Aulas/IRFID/11-12/docs/NFC%20Data%20Exchange%20Format%20(NDEF).pdf) for details. The `TINFNDEFType` is defined as: 

```swift
public protocol TINFCNDEFType : CustomStringConvertible {
    var encodedPayload: String? { get }
    var locale: String? { get }
    var encoding: String.Encoding? { get }
}
```
which give you more accessible information about the payload than the CoreNFC framework does at the moment (implementations handle, e.g. encoding, url prefixing and locale matching, information that the core framework delivers in raw bytes...). To use this just do:

```swift
func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]){
  var type: String = "Unknown"
  var text: String = "No Text"      
  for message:NFCNDEFMessage in messages {          
    message.records.forEach({ (record) in
      NSLog("Record Type: \(record.parsedPayload)")
      text = record.parsedPayload.encodedPayload!
      type = record.typeString
     })
     ...          
   }
}
```
Or whatever fits your need. You can easily inspect your payload further and act on whatever information is in the string representation. 

### Limitations

As of now, binary MIME types (such as `image/jpeg`) should not be handled with this pod. We will consider incorporating this but see no need given the limited capacity of a NFC tag (and again: weekend). Vcards, geo address URIs, and other well known URIs as by the [NFC Record Type Format Specification](https://www.cardsys.dk/download/NFC_Docs/NFC%20Record%20Type%20Definition%20(RTD)%20Technical%20Specification.pdf) will work just fine.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This Wrapper uses [CoreNFC](https://developer.apple.com/documentation/corenfc). CoreNFC requires iOS 11 so the wrapper or the example application won't work on older version of iOS. Furthermore, as by the [Specification](https://developer.apple.com/documentation/corenfc), all NFC enabled Apps will only work on iPhones 7 and 7 Plus or newer.

## Installation

TICoreNFCExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TICoreNFCExtensions'
```

## Author

Thomas Prosser, thomIT GmbH, tp@thomit.com
Please feel free to submit pull requests.

## License

TICoreNFCExtensions is available under the MIT license. See the LICENSE file for more info.
