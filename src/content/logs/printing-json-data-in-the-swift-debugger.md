---
title: "Printing JSON Data in the Swift debugger"
date: 2026-06-10
type: Log
tags:
  - Swift
  - iOS
  - Debugging
---

Tiny Swift debugging tip.

When I have JSON arriving as a `Data` object and I just want to inspect it in the debugger, this expression gives me the display I expected to see:

```swift
NSString(data: data, encoding: 1)
```

I had usually reached for this:

```swift
String(data: data, encoding: .utf8)
```

But in the debugger, the `NSString` version is often the nicer display expression.

Here is a tiny example payload:

```swift
let json = """
{
  "id": 42,
  "name": "Ido",
  "platform": "iOS",
  "debugTip": "Use NSString to inspect JSON Data in the debugger",
  "isUseful": true
}
"""

let data = Data(json.utf8)
```

And here is the difference in LLDB:

```text
(lldb) po String(data: data, encoding: .utf8)
▿ {
  "id": 42,
  "name": "Ido",
  "platform": "iOS",
  "debugTip": "Use NSString to inspect JSON Data in the debugger",
  "isUseful": true
}
  - some : "{\n  \"id\": 42,\n  \"name\": \"Ido\",\n  \"platform\": \"iOS\",\n  \"debugTip\": \"Use NSString to inspect JSON Data in the debugger\",\n  \"isUseful\": true\n}"
(lldb) po NSString(data: data, encoding: String.Encoding.utf8.rawValue)
▿ {
  "id": 42,
  "name": "Ido",
  "platform": "iOS",
  "debugTip": "Use NSString to inspect JSON Data in the debugger",
  "isUseful": true
}
  - some : {
  "id": 42,
  "name": "Ido",
  "platform": "iOS",
  "debugTip": "Use NSString to inspect JSON Data in the debugger",
  "isUseful": true
}
```

The first expression decodes the data, but LLDB still shows the optional's inner value as an escaped Swift `String`. The `NSString` expression gives me the JSON text in a more readable shape.

The `1` in the shorter expression is not random. It is the raw value for ASCII string encoding:

```swift
String.Encoding.ascii.rawValue // 1
String.Encoding.utf8.rawValue  // 4
```

If I want to be more explicit, I can also use the UTF-8 raw value:

```swift
NSString(data: data, encoding: String.Encoding.utf8.rawValue)
```

This is only a debugger display tip. For app code, JSON parsing, or user-facing data handling, I still want the normal Swift decoding path.
