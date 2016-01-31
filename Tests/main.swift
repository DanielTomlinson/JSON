import Spectre
@testable import JSON

describe("JSON handling of swift dictionaries") {
	let testObject: [String: Any] = [
		"name": "JSON",
	   	"owner": [
			"name": "Daniel Tomlinson",
			"twitter": "DanToml",
			"email": "dan@tomlinson.io"
		],
		"tags": [
			"software developer",
			"cyclist",
			"reader"
		],
		"followers": 1800,
		"pi": 3.14
	]

	$0.it("Should convert a dictionary to a JSON Dictionary") {
		let json = testObject.JSONValue
		try expect(json.dictionaryValue != nil) == true
	}

	$0.it("Should correctly encode values") {
		let json = testObject.JSONValue
		let dictionary = json.dictionaryValue!
		
		try expect(dictionary.keys.count) == 5
		try expect(dictionary["owner"]?.dictionaryValue?.keys.count) == 3
		try expect(dictionary["tags"]?.arrayValue?.count) == 3
		try expect(dictionary["pi"]?.doubleValue) == 3.14
		try expect(dictionary["followers"]?.intValue) == 1800
	}
}

describe("String Printing") {
	let testObject: [String: Any] = [
		"name": "JSON",
	   	"owner": [
			"name": "Daniel Tomlinson",
			"twitter": "DanToml",
			"email": "dan@tomlinson.io"
		],
		"tags": [
			"software developer",
			"cyclist",
			"reader"
		],
		"followers": 1800,
		"pi": 3.14
	]
	
	let testArray: [Any] = [
		1,
		2,
		3.14,
		4,
		5,
		6.0,
		"Hello",
		true,
		false,
		[1, 2, 3, 4],
		["name": "Steve", "followers": 1200]
	]

	$0.it("should correctly output objects") {
		let json = testObject.JSONValue.description

		try expect(json) == "{\"owner\":{\"email\":\"dan@tomlinson.io\",\"twitter\":\"DanToml\",\"name\":\"Daniel Tomlinson\"},\"tags\":[\"software developer\",\"cyclist\",\"reader\"],\"pi\":3.14,\"followers\":1800,\"name\":\"JSON\"}"
	}

	$0.it("should correctly output arrays") {
		let json = testArray.JSONValue.description

		try expect(json) == "[1,2,3.14,4,5,6,\"Hello\",true,false,[1,2,3,4],{}]"
	}
}

