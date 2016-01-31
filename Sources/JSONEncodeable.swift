
public protocol JSONEncodeable {
	var JSONValue: JSON { get }
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

extension Dictionary: JSONEncodeable {
	public var JSONValue: JSON {
		var json = [String : JSON]()
		for (key, value) in self {
			guard let value = value as? JSONEncodeable else { continue } // TODO: Handle this error case
			json["\(key)"] = value.JSONValue
		}

		return JSON.ObjectValue(json)
	}
}

extension Array: JSONEncodeable {
	public var JSONValue: JSON {
		var json = [JSON]()
		for value in self {
			guard let value = value as? JSONEncodeable else { continue } // TODO: Handle this error case
			json.append(value.JSONValue)
		}

		return JSON.ArrayValue(json)
	}
}
