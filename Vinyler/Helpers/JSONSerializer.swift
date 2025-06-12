/*The MIT License (MIT)
 Copyright (c) 2015 Peter Helstrup Jensen
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.*/

import Foundation
import os

/// Handles Convertion from instances of objects to JSON strings. Also helps with casting strings of JSON to Arrays or Dictionaries.
open class JSONSerializer {
    
    /**
     Errors that indicates failures of JSONSerialization
     - JsonIsNotDictionary:    -
     - JsonIsNotArray:            -
     - JsonIsNotValid:            -
     */
    public enum JSONSerializerError: Error {
        case jsonIsNotDictionary
        case jsonIsNotArray
        case jsonIsNotValid
    }
    
    //http://stackoverflow.com/questions/30480672/how-to-convert-a-json-string-to-a-dictionary
    /**
     Tries to convert a JSON string to a NSDictionary. NSDictionary can be easier to work with, and supports string bracket referencing. E.g. personDictionary["name"].
     - parameter jsonString:    JSON string to be converted to a NSDictionary.
     - throws: Throws error of type JSONSerializerError. Either JsonIsNotValid or JsonIsNotDictionary. JsonIsNotDictionary will typically be thrown if you try to parse an array of JSON objects.
     - returns: A NSDictionary representation of the JSON string.
     */
    public static func toDictionary(_ jsonString: String) throws -> NSDictionary {
        if let dictionary = try jsonToAnyObject(jsonString) as? NSDictionary {
            return dictionary
        } else {
            throw JSONSerializerError.jsonIsNotDictionary
        }
    }
    
    /**
     Tries to convert a JSON string to a NSArray. NSArrays can be iterated and each item in the array can be converted to a NSDictionary.
     - parameter jsonString:    The JSON string to be converted to an NSArray
     - throws: Throws error of type JSONSerializerError. Either JsonIsNotValid or JsonIsNotArray. JsonIsNotArray will typically be thrown if you try to parse a single JSON object.
     - returns: NSArray representation of the JSON objects.
     */
    public static func toArray(_ jsonString: String) throws -> NSArray {
        if let array = try jsonToAnyObject(jsonString) as? NSArray {
            return array
        } else {
            throw JSONSerializerError.jsonIsNotArray
        }
    }
    
    /**
     Tries to convert a JSON string to AnyObject. AnyObject can then be casted to either NSDictionary or NSArray.
     - parameter jsonString:    JSON string to be converted to AnyObject
     - throws: Throws error of type JSONSerializerError.
     - returns: Returns the JSON string as AnyObject
     */
    fileprivate static func jsonToAnyObject(_ jsonString: String) throws -> Any? {
        var any: Any?
        
        if let data = jsonString.data(using: String.Encoding.utf8) {
            do {
                any = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            }
            catch let error as NSError {
                let sError = String(describing: error)
                NSLog(sError)
                throw JSONSerializerError.jsonIsNotValid
            }
        }
        return any
    }
    
    /**
     Generates the JSON representation given any custom object of any custom class. Inherited properties will also be represented.
     - parameter object:    The instantiation of any custom class to be represented as JSON.
     - returns: A string JSON representation of the object.
    */
    
    public static func toJson<T: Encodable>(_ object: T, prettify: Bool = false) -> String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase // JSON 키를 스네이크 케이스로 변환
        encoder.outputFormatting = prettify ? .prettyPrinted : []

        do {
            let jsonData = try encoder.encode(object)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                os_log("Failed to convert JSON data to string", type: .error)
                return "{}" // 빈 JSON 반환
            }
        } catch {
            os_log("JSON encoding failed: %@", type: .error, error.localizedDescription)
            return "{}" // 빈 JSON 반환
        }
    }
}
