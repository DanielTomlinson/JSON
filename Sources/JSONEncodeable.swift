
public protocol JSONEncodeable {
	var JSONValue: JSON	{ get }
}

extension Bool: JSONEncodeable {
	public var JSONValue: JSON {
		return JSON.BooleanValue(self)
	}
}

extension String: JSONEncodeable {
	public var JSONValue: JSON {
		return JSON.StringValue(self)
	}
}

extension Float: JSONEncodeable {
	public var JSONValue: JSON {
		return JSON.NumberValue(Double(self))
	}
}

extension Double: JSONEncodeable {
	public var JSONValue: JSON {
		return JSON.NumberValue(self)
	}
}

extension Int: JSONEncodeable {
	public var JSONValue: JSON {
		return JSON.NumberValue(Double(self))
	}
}

