# TICoreNFCExtensions

[![CI Status](http://img.shields.io/travis/thomi137/TICoreNFCExtensions.svg?style=flat)](https://travis-ci.org/thomi137/TICoreNFCExtensions)
[![Version](https://img.shields.io/cocoapods/v/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)
[![License](https://img.shields.io/cocoapods/l/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)
[![Platform](https://img.shields.io/cocoapods/p/TICoreNFCExtensions.svg?style=flat)](http://cocoapods.org/pods/TICoreNFCExtensions)

## Motivation

As of iOS 11, Apple opened up their NFC hardware so developers can make their apps read NFC Tags that carry payloads compliant to the [NDEF](http://sweet.ua.pt/andre.zuquete/Aulas/IRFID/11-12/docs/NFC%20Data%20Exchange%20Format%20(NDEF).pdf)

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
