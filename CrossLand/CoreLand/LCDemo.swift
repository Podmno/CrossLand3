import SwiftUI

/// Generate Demo Struct Data
public class LCDemo : NSObject {
    
    public var cookie_html = ""
    
    public override init() {
        super.init()
        
        let cookie_html_url = Bundle.main.url(forResource: "cookie_html_main", withExtension: "txt")
        if cookie_html_url != nil {
            
            cookie_html = try! String(contentsOf: cookie_html_url!)
        }
    }
    
    public static func getStaticUserCookie() -> LGUserCookie {
        var user_cookie = LGUserCookie()
        user_cookie.userActiveCookieCount = 99
        user_cookie.userTotalCookieCount = 100
        user_cookie.cookieList.append(LGCookie(id: 123, hash: "KsqweZ", avaliableDate: "2020-01-01 00:00:00", generatedDate: "2020-01-01 00:00:00"))
        user_cookie.cookieList.append(LGCookie(id: 456, hash: "OPxamw", avaliableDate: "2020-01-01 00:00:00", generatedDate: "2020-01-01 00:00:00"))
        user_cookie.cookieList.append(LGCookie(id: 789, hash: "Iusodl", avaliableDate: "2020-01-01 00:00:00", generatedDate: "2020-01-01 00:00:00"))
        user_cookie.cookieList.append(LGCookie(id: 000, hash: "Xcuhas", avaliableDate: "2020-01-01 00:00:00", generatedDate: "2020-01-01 00:00:00"))
        return user_cookie
    }
}
