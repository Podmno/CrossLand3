//
//  LCRequest.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/20.
//

import Foundation
import Alamofire
import SwiftyJSON

/// 打印 Request 内容日志 包括网络请求得到的 JSON 内容
let requestAPIDebugOutput = true

/// Network Request Foundation
open class LCRequest : NSObject {
    
    let requestManager = LCRequestManager()
    
    let baseUrl = "https://api.nmb.best/api/"
    
    let domainGetCDNDomain = "getCDNPath"
    let domainGetForumList = "getForumList"
    let domainGetTimelineList = "getTimelineList"
    let domainShowForum = "showf"
    let domainTimeline = "timeline"
    let domainThread = "thread"
    let domainPo = "po"
    let domainRef = "ref"
    let domainFeed = "feed"
    let domainAddFeed = "addFeed"
    let domainDeleteFeed = "delFeed"
    
    let domainWebsiteJsonNotice = "https://nmb.ovear.info/nmb-notice.json"
    
    let urlWebsiteNotice = "https://www.nmbxd.com/home/forum/doPostThread.html"
    let urlWebReply = "https://www.nmbxd.com/home/forum/doReplyThread.html"
    let urlWebRandomCover = "https://nmb.ovear.info/h.php"
    
    func getCDNPath() -> String {
        print("CoreRequest > Requesting CDN Path...")
        
        var default_cdn_url = "https://image.nmb.best/"
        var default_cdn_rate: Float = 0.0
        
        let semaphore = DispatchSemaphore.init(value: 0)
        let queue = DispatchQueue.init(label: "studio.tri.LandX.getCDNPath")
        
        queue.async {
            AF.request(self.baseUrl + self.domainGetCDNDomain).response { response in
                if(response.error != nil) {
                    print("CoreRequest > getCDNPath - Request Error")
                    default_cdn_url = "LCRequest.Error.Alamofire." + response.error!.localizedDescription
                    semaphore.signal()
                    return
                }
                
                let j = JSON(response.result)
                for (_, subJ) in j {
                    let remote_domain_rate = subJ["rate"].float ?? 0.0
                    
                    if(remote_domain_rate > default_cdn_rate) {
                        let remote_domain = subJ["url"].string ?? ""
                        default_cdn_url = remote_domain
                        default_cdn_rate = remote_domain_rate
                        print("CoreRequest > Updated CDN path \(default_cdn_url) for rate \(default_cdn_rate)")
                    }
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return default_cdn_url
    }
    
    func getForumList() -> JSON {
        print("CoreRequest > Requesting Forum List...")

        let url = baseUrl + domainGetForumList
        let re = requestManager.serialRequest(url: url)
        return re
    }
    
    func getTimelineList() -> JSON {
        print("CoreRequest > Requesting Timeline List...")
        
        let url = baseUrl + domainGetTimelineList
        return requestManager.serialRequest(url: url)
    }
    
    func showForum(fid: UInt, fPage: UInt) -> JSON {
        
        print("CoreRequest > Show Forum for ID \(fid) page \(fPage)...")
        
        let url = baseUrl + domainShowForum
        let argc = ["id":"\(fid)", "page":"\(fPage)"]
        return requestManager.serialRequestWithArguments(url: url, arguments: argc)
        
    }
    
    func showTimeline(thid: UInt, thpage: UInt) -> JSON {
        
        print("CoreRequest > Show Timeline for ID \(thid) page \(thpage)...")
        
        let url = baseUrl + domainTimeline
        let argc = ["id":"\(thid)", "page":"\(thpage)"]
        
        return requestManager.serialRequestWithArguments(url: url, arguments: argc)
        
    }
    
    func showThread(tid: UInt, tpage: UInt) -> JSON {
        
        print("CoreRequest > Show Thread for ID \(tid) page \(tpage)...")
        
        let url = baseUrl + domainThread
        let argc = ["id":tid, "page":tpage]
        
        return requestManager.serialRequestWithArguments(url: url, arguments: argc)
        
    }
    
    func showPo(tid: UInt, tpage: UInt) {
        
        print("CoreRequest > Show Po \(tid) for Page \(tpage)...")
        
    }
    
    func showReference(tid: UInt) -> JSON {
        
        print("CoreRequest > Show Reference \(tid)...")
        
        let url = baseUrl + domainRef
        let argc = ["id":tid]
        
        return requestManager.serialRequestWithArguments(url: url, arguments: argc)
    }
    
    
    func sendPost() {
        
        
        
    }
    
    func sendReply() {
        
        
    }
    
    
    func showFeed() {
        
        
        
    }
    
    func addFeed() {
        
        
        
    }
    
    
    func deleteFeed() {
        
        
    }
    
    func getNotice() {
        AF.request(domainWebsiteJsonNotice).response { re in
            debugPrint(re)
        }
    }
    
    
    func getRandomCover() {
        
        
        
    }
}

// Core Request 总网络请求
open class LCRequestManager : NSObject {
    
    public func serialRequest(url: String) -> JSON {
        
        print("Request - Serial request for url > \(url)")
        
        let semaphore = DispatchSemaphore.init(value: 0)
        let queue = DispatchQueue.init(label: "studio.tri.LandX.serialRequest")
        
        var result = JSON()
        
        queue.async {
            
            AF.request(url,method: .get,encoding: URLEncoding.default).response { response in
                
                if(response.error != nil) {
                    print("Request - Error for \(response.debugDescription)")
                    semaphore.signal()
                    return
                }
                
                result = JSON(response.data as Any)
                if(requestAPIDebugOutput) { print(result) }
                semaphore.signal()
            }
            
        }

        semaphore.wait()
        return result
    }
    
    public func serialRequestWithArguments(url: String, arguments: Dictionary<String, Any>) -> JSON {
        
        print("Request - Serial request for url > \(url) with arguments \(arguments)")
        
        let semaphore = DispatchSemaphore.init(value: 0)
        let queue = DispatchQueue.init(label: "studio.tri.LandX.serialRequestWithArguments")
        
        var result = JSON()
        
        queue.async {
            
            AF.request(url,method: .get,parameters: arguments,encoding: URLEncoding.default).response { response in
                
                if(response.error != nil) {
                    print("Request - Error for \(response.debugDescription)")
                    semaphore.signal()
                    return
                }
                
                result = JSON(response.data as Any)
                if(requestAPIDebugOutput) { print(result) }
                semaphore.signal()
            }
        }

        semaphore.wait()
        return result
        
    }
    
    
}
