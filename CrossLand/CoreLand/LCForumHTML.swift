//
//  LCForumHTML.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/24.
//

import UIKit
import ZMarkupParser

public struct LCForumHTMLNode {
    public var content: String
}

public class LCForumHTML : NSObject {
    
    public static let shared = LCForumHTML()
    
    let parser = ZHTMLParserBuilder.initWithDefault().set(rootStyle: MarkupStyle(font: MarkupStyleFont(UIFont.preferredFont(forTextStyle: .body)), foregroundColor: MarkupStyleColor(color: UIColor.label))).build()
    
    public func parseAttributedLabel(content: String) -> NSAttributedString {
        
        let pre_parser =  parser.render(content)
        let font_apply = NSMutableAttributedString(attributedString: pre_parser)
        
    
        //let html_a_label_pattern = "<a+.*?>([\\s\\S]*?)|</a*?>"
        //let regex = try! NSRegularExpression(pattern: html_a_label_pattern)
        //let th_replace_result = regex.stringByReplacingMatches(in: content, range: NSRange(location: 0, length: content.count), withTemplate: "")
        //let data = th_replace_result.data(using: .unicode)
        
        
        let systemFont = UIFont.preferredFont(forTextStyle: .body)
        let attr = [NSAttributedString.Key.font: systemFont]
        
        
        //if let attributedString = try? NSMutableAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
         font_apply.addAttributes(attr, range: NSRange(location: 0, length: font_apply.length))
            //attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
    
        // 后处理 >> 跳页
        let expression = try! NSRegularExpression(pattern: ">>No.([0-9]*)")
        
        let array = expression.matches(in: font_apply.string, range: NSRange(location: 0, length: font_apply.length))
        for result in array {
            let str_data = (font_apply.string as NSString).substring(with: result.range)
            let target = TRRegexTool.shared.replaceList(validateStr: str_data, regularExpressList: [">>","No."], contentStr: "")
            font_apply.addAttribute(NSAttributedString.Key.link, value: URL(string: "/t/\(target)")!, range: result.range)
            // TODO: 链接颜色不生效
            if #available(iOS 15.0, *) {
                let linkAttributes: [NSAttributedString.Key : Any] = [
                    //NSAttributedString.Key.foregroundColor: UIColor.green,
                    NSAttributedString.Key.underlineColor: UIColor.tintColor,
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                font_apply.addAttributes(linkAttributes, range: result.range)
            } else {
                let linkAttributes: [NSAttributedString.Key : Any] = [
                    //NSAttributedString.Key.foregroundColor: UIColor.green,
                    NSAttributedString.Key.underlineColor: UIColor.accent,
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                font_apply.addAttributes(linkAttributes, range: result.range)
            }

            
        }
        
        return font_apply
        //}
        //return NSAttributedString(string: content)
    }
    
}


//let html_a_label_pattern = "<a+.*?>([\\s\\S]*?)|</a*?>"
//let regex = try! NSRegularExpression(pattern: html_a_label_pattern)
//let th_replace_result = regex.stringByReplacingMatches(in: content, range: NSRange(location: 0, length: content.count), withTemplate: "")
//let data = th_replace_result.data(using: .unicode)
//
//
//let systemFont = UIFont.preferredFont(forTextStyle: .body)
//let attr = [NSAttributedString.Key.font: systemFont]
//
//
//if let attributedString = try? NSMutableAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//    attributedString.addAttributes(attr, range: NSRange(location: 0, length: attributedString.length))
//    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
//
//    return attributedString
//}
//return NSAttributedString(string: content)
