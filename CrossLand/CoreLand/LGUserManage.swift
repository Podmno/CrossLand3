import Foundation
import Alamofire

public struct LGUserCookie {
    public var userActiveCookieCount: Int = 0
    public var userTotalCookieCount: Int = 0
    
    public var cookieList: [LGCookie] = []
}

public struct LGCookie {
    public var id: Int = 0
    public var hash: String = ""
    public var avaliableDate: String = ""
    public var generatedDate: String = ""
}

public class LGDomainLibrary: NSObject {
    public static let domainGetVerifyCode = "https://www.nmbxd1.com/Member/User/Index/verify.html"
    public static let domainGetLoginPage = "https://www.nmbxd1.com/Member/User/Index/login.html"
    public static let domainSignout = "https://www.nmbxd1.com/Member/User/Index/logout.html"
    public static let domainAccountIndex = "https://www.nmbxd1.com/Member/User/Index/index.html"
    public static let domainCookieIndex = "https://www.nmbxd1.com/Member/User/Cookie/index.html"
    
    public static func domainGetApplyCookie(cookieID: Int) -> String {
        return "https://www.nmbxd1.com/Member/User/Cookie/switchTo/id/\(cookieID).html"
    }
    public static func domainGetQRCodeCookie(cookieID: Int) -> String {
        return "https://www.nmbxd1.com/Member/User/Cookie/export/id/\(cookieID).html"
    }
    public static func domainDeleteCookie(cookieID: Int) -> String {
        return "https://www.nmbxd1.com/Member/User/Cookie/delete/id/\(cookieID).html"
    }
    
}

public enum LGLoginStatusCode : Int {
    case success = 0
    case internalError = -1
    case internetError = -2
    case unknown = -5
    case userNotFound = -10
    case verifyCodeIncorrect = -9
    case passwordIncorrect = -8
}

public enum LGOperationStatusCode : Int {
    case success = 0
    case notLoggedIn = -1
    case internetError = -2
}

public class LGUserManage: NSObject {
    public func requestLoginPage() -> String {
        
        print("* LandSystem: get Login WebPage")
        let se = DispatchSemaphore(value: 0)
        var sha_repo = "error"
        var content_html = ""
        
        AF.request(LGDomainLibrary.domainGetLoginPage, method: .get).response { response in
            if (response.error == nil) {
                let repo_html = String(data: response.data!, encoding: .utf8)
                debugPrint(repo_html ?? "")
                content_html = repo_html ?? ""
                print("* LandSystem: HTML Get OK.")
                print(content_html)
                
                if (content_html.contains("登出") || content_html.contains("修改密码")) {
                    sha_repo = "already"
                }
            } else {
                print("* LandSystem: failed to get webpage.")
            }
            se.signal()
        }
        se.wait()
        
        if (sha_repo == "already") {
            return sha_repo
        }
        let regix = "name=\"__hash__\" value=\"(([\\s\\S])*?)\""
        let RE = try! NSRegularExpression(pattern: regix)
        let matches = RE.matches(in: content_html, range: NSRange(location: 0, length: content_html.count))
        let result_range = matches.first?.range
        
        if (result_range == nil) {
            return sha_repo
        }
        
        let swiftRange = Range(result_range!, in: content_html)
        let range_repo = content_html[swiftRange!]
        
        let split_repo = range_repo.split(separator: "\"")
        print(split_repo)
        
        for sp_str in split_repo {
            if (sp_str.contains("name") || sp_str.contains("hash") || sp_str.contains("value")  ) {
                continue
            } else {
                sha_repo.append("\(sp_str)")
            }
        }
        
        print("* LandSystem: SHA repo \(sha_repo)")
        
        return sha_repo
    }
    
    public func receiveVerifyCode() -> Data? {
        print("* LandSystem: receive Verify Code")
        var response_data: Data? = nil
        let se = DispatchSemaphore(value: 0)
        AF.request(LGDomainLibrary.domainGetVerifyCode).response { response in
            if response.error == nil {
                response_data = response.data
            }
            se.signal()
        }
        
        se.wait()
        return response_data
    }
    
    public func loginProcess(user: String, pwd: String, verify: String, verifyHash: String) -> LGLoginStatusCode {
        print("* LandSystem: ready to login!")
        var login_repo: LGLoginStatusCode = .unknown
        
        let se = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: URL(string: LGDomainLibrary.domainGetLoginPage)!)
        request.httpMethod = HTTPMethod.post.rawValue
        let http_body_content = "email=\(user)&password=\(pwd)&verify=\(verify)&__hash__=\(verifyHash)"
        //request.headers = headers
        request.httpBody = http_body_content.data(using: .utf8)
        AF.request(request).response { responds in
            debugPrint(responds)
            
            if (responds.error != nil) {
                login_repo = .internetError
                se.signal()
                return
            }
            
            let repo_html = String(data: responds.data!, encoding: .utf8) ?? ""
            //debugPrint(repo_html)
            
            if (repo_html.contains("登陆成功")) {
                login_repo = .success
            }
            
            if (repo_html.contains("用户不存在")) {
                login_repo = .userNotFound
            }
            
            if (repo_html.contains("验证码错误")) {
                login_repo = .verifyCodeIncorrect
            }
            
            if (repo_html.contains("账户密码与数据库中不匹配")) {
                login_repo = .passwordIncorrect
            }
            
            se.signal()
        }
        se.wait()
        return login_repo
    }
    
    public func userCookie() -> LGUserCookie {
        print("* LandSysten: user Cookie Web Page")
        let se = DispatchSemaphore(value: 0)
        var user_cookie = LGUserCookie()
        let parser_tool = LCParser()
        AF.request(LGDomainLibrary.domainCookieIndex).response { response in
            if (response.error == nil) {
                let html = String(data: response.data ?? Data(), encoding: .utf8) ?? ""
                user_cookie = parser_tool.parseWebLandUserCookieTotal(cookieWebHTML: html, userCookie: user_cookie)
                user_cookie = parser_tool.parseWebLandUserCookieList(cookieWebHTML: html, userCookie: user_cookie)
                print(" ==== User Cookie ====")
                print(user_cookie)
                print(" =====================")
            } else {
                print("Failed to get user cookie web page.")
            }
            se.signal()
        }
        se.wait()
        return user_cookie
    }
    
    public func applyCookie(cookieID: Int) -> LGOperationStatusCode {
        let request_url = LGDomainLibrary.domainGetApplyCookie(cookieID: cookieID)
        var result_code: LGOperationStatusCode = .internetError
        let se = DispatchSemaphore(value: 0)
        AF.request(request_url).response { response in
            if (response.error == nil) {
                let repo_html = String(data: response.data ?? Data(), encoding: .utf8) ?? ""
                print(repo_html)
                if (repo_html.contains("饼干切换成功")) {
                    result_code = .success
                } else {
                    result_code = .notLoggedIn
                }
            } else {
                print("* Faied to get webpage.")
                result_code = .internetError
            }
            se.signal()
        }
        
        se.wait()
        return result_code
    }
    
    public func signOut() -> LGOperationStatusCode {
        
        print("* LandSystem: sign out!")
        var status_code: LGOperationStatusCode = .internetError
        
        let se = DispatchSemaphore(value: 0)
        
        AF.request(LGDomainLibrary.domainSignout).response { response in
            if (response.error == nil) {
                let repo_html = String(data: response.data!, encoding: .utf8) ?? ""
                print("* LandSystem: HTML Get OK.")
                print(repo_html)
                
                if (repo_html.contains("登出成功")) {
                    status_code = .success
                } else {
                    status_code = .notLoggedIn
                }
                
                
            } else {
                print("* LandSystem: failed to get webpage.")
                status_code = .internetError
            }
            
            se.signal()
        }
        
        se.wait()
        return status_code
    }
}

