// This file has been modified from its original project zewo/JSON

public enum JSONErrors: ErrorType {
	case UnsupportedValue
}

public enum JSON {
    case NullValue
    case BooleanValue(Bool)
    case NumberValue(Double)
    case StringValue(String)
    case ArrayValue([JSON])
    case ObjectValue([String: JSON])

    public var isBoolean: Bool {
        switch self {
        case .BooleanValue: return true
        default: return false
        }
    }

    public var isNumber: Bool {
        switch self {
        case .NumberValue: return true
        default: return false
        }
    }

    public var isString: Bool {
        switch self {
        case .StringValue: return true
        default: return false
        }
    }

    public var isArray: Bool {
        switch self {
        case .ArrayValue: return true
        default: return false
        }
    }

    public var isObject: Bool {
        switch self {
        case .ObjectValue: return true
        default: return false
        }
    }

    public var boolValue: Bool? {
        switch self {
        case .BooleanValue(let b): return b
        default: return nil
        }
    }

    public var doubleValue: Double? {
        switch self {
        case .NumberValue(let n): return n
        default: return nil
        }
    }

    public var intValue: Int? {
        if let v = doubleValue {
            return Int(v)
        }
        return nil
    }

    public var uintValue: UInt? {
        if let v = doubleValue {
            return UInt(v)
        }
        return nil
    }

    public var stringValue: String? {
        switch self {
        case .StringValue(let s): return s
        default: return nil
        }
    }

    public var arrayValue: [JSON]? {
        switch self {
        case .ArrayValue(let array): return array
        default: return nil
        }
    }

    public var dictionaryValue: [String: JSON]? {
        switch self {
        case .ObjectValue(let dictionary): return dictionary
        default: return nil
        }
    }

    public subscript(index: UInt) -> JSON? {
        set {
            switch self {
            case .ArrayValue(let a):
                var a = a
                if Int(index) < a.count {
                    if let json = newValue {
                        a[Int(index)] = json
                    } else {
                        a[Int(index)] = .NullValue
                    }
                    self = .ArrayValue(a)
                }
            default: break
            }
        }
        get {
            switch self {
            case .ArrayValue(let a):
                return Int(index) < a.count ? a[Int(index)] : nil
            default: return nil
            }
        }
    }

    public subscript(key: String) -> JSON? {
        set {
            switch self {
            case .ObjectValue(let o):
                var o = o 
                o[key] = newValue
                self = .ObjectValue(o)
            default: break
            }
        }
        get {
            switch self {
            case .ObjectValue(let o):
                return o[key]
            default: return nil
            }
        }
    }

    public func serialize(serializer: JSONSerializer) -> String {
        return serializer.serialize(self)
    }
}

extension JSON: CustomStringConvertible {
    public var description: String {
        return serialize(DefaultJSONSerializer())
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        return serialize(PrettyJSONSerializer())
    }
}

extension JSON: Equatable {}

public func ==(lhs: JSON, rhs: JSON) -> Bool {
    switch lhs {
    case .NullValue:
        switch rhs {
        case .NullValue: return true
        default: return false
        }
    case .BooleanValue(let lhsValue):
        switch rhs {
        case .BooleanValue(let rhsValue): return lhsValue == rhsValue
        default: return false
        }
    case .StringValue(let lhsValue):
        switch rhs {
        case .StringValue(let rhsValue): return lhsValue == rhsValue
        default: return false
        }
    case .NumberValue(let lhsValue):
        switch rhs {
        case .NumberValue(let rhsValue): return lhsValue == rhsValue
        default: return false
        }
    case .ArrayValue(let lhsValue):
        switch rhs {
        case .ArrayValue(let rhsValue): return lhsValue == rhsValue
        default: return false
        }
    case .ObjectValue(let lhsValue):
        switch rhs {
        case .ObjectValue(let rhsValue): return lhsValue == rhsValue
        default: return false
        }
    }
}

extension JSON: NilLiteralConvertible {
    public init(nilLiteral value: Void) {
        self = .NullValue
    }
}

extension JSON: BooleanLiteralConvertible {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .BooleanValue(value)
    }
}

extension JSON: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .NumberValue(Double(value))
    }
}

extension JSON: FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self = .NumberValue(Double(value))
    }
}

extension JSON: StringLiteralConvertible {
    public typealias UnicodeScalarLiteralType = String

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .StringValue(value)
    }
    
    public typealias ExtendedGraphemeClusterLiteralType = String
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterType) {
        self = .StringValue(value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self = .StringValue(value)
    }
}

extension JSON: ArrayLiteralConvertible {
    public init(arrayLiteral elements: JSON...) {
        self = .ArrayValue(elements)
    }
}

extension JSON: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, JSON)...) {
        var dictionary = [String: JSON](minimumCapacity: elements.count)

        for pair in elements {
            dictionary[pair.0] = pair.1
        }
        
        self = .ObjectValue(dictionary)
    }
}
