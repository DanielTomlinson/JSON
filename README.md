# JSON

JSON is a fork of [JSON by Zewo](https://github.com/zewo/JSON) that allows custom
types to be serialized using the `JSONEncodable` protocol.

## Usage

```swift
import JSON

// parse JSON string

let json = try! JSONParser.parse("{\"foo\":\"bar\"}")

let json: JSON = [
    "null": nil,
    "string": "Foo Bar",
    "boolean": true,
    "array": [
        "1",
        2,
        nil,
        true,
        ["1", 2, nil, false],
        ["a": "b"]
    ],
    "object": [
        "a": "1",
        "b": 2,
        "c": nil,
        "d": false,
        "e": ["1", 2, nil, false],
        "f": ["a": "b"]
    ],
    "number": 1969
]
```

## Installation

- Add `JSON` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/DanielTomlinson/JSON.git", majorVersion: 0, minor: 4)
    ]
)
```

License
-------

**JSON** is released under the MIT license. See LICENSE for details.
