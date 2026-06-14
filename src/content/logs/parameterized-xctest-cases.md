---
title: "Parameterized XCTest Cases"
date: 2026-06-14
type: Log
tags:
  - Swift
  - iOS
  - Testing
  - XCTest
---

Some XCTest files slowly collect several tests that are almost the same.

Same setup.

Same action.

Same assertions.

Only one value changes.

That kind of repetition is easy to create because each test still looks reasonable on its own. But after the third or fourth copy, the real scenario becomes harder to see. The test file gets larger, the setup gets duplicated, and changing the shared expectation means touching several places.

I like having a small `parameterize` helper for that shape of test.

It does not reduce the number of cases the test suite executes. It reduces the number of test methods I have to write and maintain.

Each value becomes a parameter case: one execution of the same test body with a different input.

## A Small Helper

This is the small version of the helper. In a real project, I would adapt it to the team's XCTest style, but the important pieces are the named activity, the parameter loop, and the fixture reset between parameter cases.

```swift
import XCTest

extension XCTestCase {
    func parameterize<Value>(
        _ values: [Value],
        title: String = "Parameter",
        test: (Value) throws -> Void
    ) rethrows {
        for value in values {
            try XCTContext.runActivity(named: "\(title): \(value)") { _ in
                defer {
                    tearDown()
                    setUp()
                }

                try test(value)
            }
        }
    }
}
```

XCTest still runs one test method, but `parameterize` turns each value into a named test activity. In practice, I want each activity to behave like a small independent parameter case, so the helper resets the fixture between values by calling `tearDown()` and `setUp()`.

That reset matters when the test uses mutable XCTestCase properties: mocks, delegates, fake data builders, adapters, expectations, or any other state that could leak from one case into the next.

## A Green Example

Here is a tiny example:

```swift
struct User {
    let age: Int

    var isAdult: Bool {
        age >= 18
    }
}

final class TestWithParameters: XCTestCase {
    func test_isAdult() {
        parameterize([17, 18, 21], title: "age") { age in
            XCTAssertEqual(User(age: age).isAdult, age >= 18)
        }
    }
}
```

This is intentionally boring. The production logic is not the point. The useful part is that the three boundary-ish values are visible in one place, while the setup and assertion stay in one test body.

If I wrote these as separate tests, the files would have more names and more duplicated structure, but not necessarily more clarity.

## When One Case Fails

The activity name becomes useful when the test expectation does not match the production logic.

For example, if I accidentally wrote the expectation as `age > 18`, the `18` case fails:

```swift
func test_isAdult() {
    parameterize([17, 18, 21], title: "age") { age in
        XCTAssertEqual(User(age: age).isAdult, age > 18)
    }
}
```

Trimmed from the XCTest output:

```text
age: 17
age: 18
XCTAssertEqual failed: ("true") is not equal to ("false")
age: 21
```

The test method failed, but the activity name tells me which parameter case exposed the mismatch.

In this kind of assertion failure, XCTest records the failed parameter case and the loop continues to the next value. Thrown errors or fatal failures can stop the flow differently, but for normal assertions this gives a useful report across the tested values.

## Matrix Cases

The same idea is even more useful when the behavior depends on a combination of values.

For that, I usually add another overload:

```swift
extension XCTestCase {
    func parameterize<Value1, Value2>(
        _ values1: [Value1],
        _ values2: [Value2],
        title1: String = "Parameter 1",
        title2: String = "Parameter 2",
        test: (Value1, Value2) throws -> Void
    ) rethrows {
        for value1 in values1 {
            for value2 in values2 {
                let activityName = "\(title1): \(value1), \(title2): \(value2)"

                try XCTContext.runActivity(named: activityName) { _ in
                    defer {
                        tearDown()
                        setUp()
                    }

                    try test(value1, value2)
                }
            }
        }
    }
}
```

Then a test can cover every combination without turning into four copied tests:

```swift
struct EmailUser {
    let isEnabled: Bool
    let hasValidEmail: Bool

    var canReceiveEmail: Bool {
        isEnabled && hasValidEmail
    }
}

final class EmailUserTests: XCTestCase {
    func test_canReceiveEmail() {
        parameterize(
            [false, true],
            [false, true],
            title1: "isEnabled",
            title2: "hasValidEmail"
        ) { isEnabled, hasValidEmail in
            let user = EmailUser(
                isEnabled: isEnabled,
                hasValidEmail: hasValidEmail
            )

            XCTAssertEqual(
                user.canReceiveEmail,
                isEnabled && hasValidEmail
            )
        }
    }
}
```

That produces four parameter cases:

```text
isEnabled: false, hasValidEmail: false
isEnabled: false, hasValidEmail: true
isEnabled: true, hasValidEmail: false
isEnabled: true, hasValidEmail: true
```

This is the version I reach for a lot in larger codebases. Many tests have a stable scenario where one feature flag, permission, status, or option changes the expected result. Matrix parameterization keeps those combinations visible without spreading the same setup across multiple test methods.

## When Not To Use It

`parameterize` is useful when the test body still tells one story.

If using it makes me add branching inside the test, I am probably missing the point. The helper should remove repeated structure, not hide multiple scenarios inside one test body.

Different setup paths, different actions, or different assertions often deserve separate tests. The utility is best when the shape stays the same and the parameter cases are the part worth naming.
