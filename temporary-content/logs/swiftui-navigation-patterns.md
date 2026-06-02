---
title: SwiftUI navigation patterns I keep using
date: 2026-05-12
type: Technical Note
tags:
  - SwiftUI
  - Navigation
---

Small routing enums are still my favorite way to keep navigation explicit without turning every screen into state soup.

```swift
enum Route: Hashable {
  case project(String)
  case log(String)
}
```
