//
//  TRRegexTool.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/25.
//

import Foundation

public class TRRegexTool : NSObject {
    public static var shared = TRRegexTool()
    
    public func regulayExpressionList(regularExpressList: [String], validateString: String) -> [String] {
        var repo_list = [validateString]
        var result_list: [String] = []
        for express in regularExpressList {
            for str in repo_list {
                let result_par = regulayExpression(regularExpress: express, validateString: str)
                result_list.append(contentsOf: result_par)
            }
            repo_list = result_list
            result_list = []
        }
        return repo_list
    }
    
    public func regulayExpression(regularExpress: String, validateString: String) -> [String] {
        do {
            let regex = try NSRegularExpression.init(pattern: regularExpress, options: [])
            let matches = regex.matches(in: validateString, options: [], range: NSRange(location: 0, length: validateString.count))
            var res: [String] = []
            for item in matches {
                let str = (validateString as NSString).substring(with: item.range)
                res.append(str)
            }
            return res
        } catch {
            return []
        }
    }
    
    public func replaceList(validateStr: String, regularExpressList: [String], contentStr: String) -> String {
        var str = validateStr
        for express in regularExpressList {
            str = replace(validateStr: str, regularExpress: express, contentStr: contentStr)
        }
        return str
    }
    
    public func replace(validateStr: String, regularExpress: String, contentStr: String) -> String {
        do {
            let regrex = try NSRegularExpression.init(pattern: regularExpress, options: [])
            let modified = regrex.stringByReplacingMatches(in: validateStr, options: [] ,range: NSRange(location: 0, length: validateStr.count), withTemplate: contentStr)
            return modified
        } catch {
            return validateStr
        }
    }
}
