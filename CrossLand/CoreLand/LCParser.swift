import Foundation
import UIKit

public class LCParser: NSObject {
    
    public static var shared = LCParser()
    
    let formatter = DateFormatter()
    public override init() {
        super.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
    }
    /// Time Convert from e.g. 2024-04-02(二)14:24:34
    public func parseThreadTime(dateString: String) -> Date {
        let dateStrRemove = TRRegexTool.shared.replace(validateStr: dateString, regularExpress: "\\((.*?)\\)", contentStr: " ")
        return formatter.date(from: dateStrRemove) ?? Date(timeIntervalSince1970: 0)
    }
    
    public func parseFont(threadContentHTML: String) -> NSAttributedString {
        let repo = NSMutableAttributedString(string: threadContentHTML)
        
        return repo
    }
    
    public func parseWebLandUserCookieTotal(cookieWebHTML: String, userCookie: LGUserCookie) -> LGUserCookie {
        var user_cookie = userCookie
        let html_repo = TRRegexTool.shared.regulayExpressionList(regularExpressList: ["饼干容量(.*?)<\\/b>", "\\[(.*?)\\]"], validateString: cookieWebHTML)
        // print(html_repo)
        if (html_repo.isEmpty) { return user_cookie }
        let first_number_pre = TRRegexTool.shared.regulayExpression(regularExpress: "\\[(.*?)\\/", validateString: html_repo[0])
        let last_number_pre = TRRegexTool.shared.regulayExpression(regularExpress: "\\/(.*?)\\]", validateString: html_repo[0])
        
        let first_number_str = TRRegexTool.shared.replaceList(validateStr: first_number_pre[0], regularExpressList: ["\\[", "\\/"], contentStr: "")
        let last_number_str = TRRegexTool.shared.replaceList(validateStr: last_number_pre[0], regularExpressList: ["\\]","\\/"], contentStr: "")
        print("Avaliable Cookie: \(first_number_str), Total Cookie: \(last_number_str)")
        
        let avaliable_cookie = Int(first_number_str) ?? 0
        let total_cookie = Int(last_number_str) ?? 0
        user_cookie.userActiveCookieCount = avaliable_cookie
        user_cookie.userTotalCookieCount = total_cookie
        print("Cookie Total: \(user_cookie)")
        return user_cookie
    }
    
    public func parseWebLandUserCookieList(cookieWebHTML: String, userCookie: LGUserCookie) -> LGUserCookie {
        print("WebLand User Cookie List")
        print(cookieWebHTML)
        var user_cookie = userCookie
        // 修改为能匹配空行
        let html_td_pre = TRRegexTool.shared.regulayExpressionList(regularExpressList: ["<td><input type=[\\s\\S]*?<\\/tr>"], validateString: cookieWebHTML)
        
        if (html_td_pre.isEmpty) { return user_cookie }
        
        for td_html in html_td_pre {
            var cookie_data = LGCookie()
            // 1. Parse Cookie ID
            let cookie_id_pre = TRRegexTool.shared.regulayExpressionList(regularExpressList: ["<td>\\d+<\\/td>"], validateString: td_html)
            if (cookie_id_pre.isEmpty) { continue }
            let cookie_id_str = TRRegexTool.shared.replaceList(validateStr: cookie_id_pre[0], regularExpressList: ["<td>", "<\\/td>"], contentStr: "")
            print(cookie_id_str)
            cookie_data.id = Int(cookie_id_str) ?? 0
            // 2. Parse Cookie Hash
            let cookie_hash_pre = TRRegexTool.shared.regulayExpressionList(regularExpressList: ["<td><a(.*?)<\\/td>", "\">(.*?)<\\/"], validateString: td_html)
            if (cookie_id_pre.isEmpty) { continue }
            //print(cookie_hash_pre)
            let cookie_hash_str = TRRegexTool.shared.replaceList(validateStr: cookie_hash_pre[0], regularExpressList: ["\">", "<\\/"], contentStr: "")
            print(cookie_hash_str)
            cookie_data.hash = cookie_hash_str
            // 3. Get Date
            let date_get_pre = TRRegexTool.shared.regulayExpressionList(regularExpressList: ["(\\d+)-(\\d+)-(\\d+) (\\d+):(\\d+):(\\d+)"], validateString: td_html)
            if (date_get_pre.count != 2) { continue }
            print(date_get_pre[1])
            cookie_data.avaliableDate = date_get_pre[0]
            cookie_data.generatedDate = date_get_pre[1]
            
            user_cookie.cookieList.append(cookie_data)
        }
        return user_cookie
    }
    

    func getTimeCurrentDescription(timeStamp: Double) -> String {
            //获取当前的时间戳
            let currentTime = Date().timeIntervalSince1970
            //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
            let timeSta:TimeInterval = TimeInterval(timeStamp)
            //时间差
            let reduceTime : TimeInterval = currentTime - timeSta
            //时间差小于60秒
            if reduceTime < 60 {
                return "刚刚"
            }
            //时间差大于一分钟小于60分钟内
            let mins = Int(reduceTime / 60)
            if mins < 60 {
                return "\(mins) 分钟前"
            }
            let hours = Int(reduceTime / 3600)
            if hours < 24 {
                return "\(hours) 小时前"
            }
            let days = Int(reduceTime / 3600 / 24)
            if days < 30 {
                return "\(days) 天前"
            }
            //不满足上述条件---或者是未来日期-----直接返回日期
            let date = NSDate(timeIntervalSince1970: timeSta)
            let dfmatter = DateFormatter()
            //yyyy-MM-dd HH:mm:ss
            dfmatter.dateFormat="yyyy 年 MM 月 dd 日 HH:mm:ss"
            return dfmatter.string(from: date as Date)
        }

}

/*

 }
 */
