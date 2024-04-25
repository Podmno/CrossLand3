//
//  LCAPI.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/20.
//

import Foundation
import SwiftyJSON
import Alamofire
// import AlamofireImage * Deprecated

/// LCAPI 的请求结果获取
public enum LCAPINetworkStatus {
    case success
    case failed
    case timeout
    case unknown
}

open class LCAPI : NSObject {
    
    let globalStorage = LCStorage.shared
    
    let request = LCRequest()
    public func getCDNPath() -> String {
        let repo = request.getCDNPath()
        LCStorage.shared.globalSaveCDNImageURL(cdnUrl: repo)
        return repo
    }
    
    /// 获取总 ForumList 列表
    public func getTotalForumList() -> [LSForumList] {
        
        let forumlist_data = request.getForumList()
        var re_array: [LSForumList] = []
        
        for (_,s_forumlist_json) in forumlist_data {
            
            let forum_list = LSForumList()
            forum_list.loadFromJSON(json: s_forumlist_json)
            
            re_array.append(forum_list)
            
        }
        return re_array
    }
    
    
    /// 获取 Timeline List
    public func getTimelineList() -> LSTimelineList {
        
        let timeline_data = request.getTimelineList()
        let timeline_list = LSTimelineList()
        timeline_list.loadFromJSON(json: timeline_data)
        return timeline_list
    }
    
    /// 获取 Thread 信息
    public func getThread(threadID: UInt, threadPage: UInt) -> LSThread {
        
        let thread_data = request.showThread(tid: threadID, tpage: threadPage)
        let th = LSThread()
        th.loadFromJSON(json: thread_data)
        
        return th
        
    }
    
    /// 获取指定 Forum 的回复
    public func getForum(forumID: UInt, forumPage: UInt) -> [LSThread] {
        var replies: [LSThread] = []
        let repo_json = request.showForum(fid: forumID, fPage: forumPage)
        
        for (_, single_repo) in repo_json {
            
            let rp = LSThread()
            rp.loadFromJSON(json: single_repo)
            replies.append(rp)
        }

        return replies
    }
    
    /// 获取指定 Timeline 的内容
    public func getTimeline(timelineID: UInt, timelinePage: UInt) -> [LSThread] {
        var repo: [LSThread] = []
        let timeline_json = request.showTimeline(thid: timelineID, thpage: timelinePage)
        
        for (_,th) in timeline_json {
            let th_struct = LSThread()
            th_struct.loadFromJSON(json: th)
            repo.append(th_struct)
        }
        return repo
    }
    
    /// 更新 ForumList 与 TimelineList 的本地存储
    public func updateForumsStorage() {
        
        
    }
    
    /// 更新 CDN 网络路径（图片保存）
    public func updateCDNNetworkPath() {
        
        
        
    }
    
    /// 检查与 X 岛的连接情况
    public func checkNetworkStatus() -> LCAPINetworkStatus {
        print("API - Check the connection to X Land...")
       
        var reply = LCAPINetworkStatus.unknown
        
        let semaphore = DispatchSemaphore.init(value: 0)
        let queue = DispatchQueue.init(label: "studio.tri.LandX.networkCheck")

        
        queue.async {
            
            AF.request("https://api.nmb.best/api/getCDNPath",method: .get,encoding: URLEncoding.default).response { response in
                
                if(response.error != nil) {
                    
                    //print("Request - Error for \(response.debugDescription)")
                    
                    //print("Response Code Error for : \(response.error?.responseCode ?? 0)")
                   
                    if response.error!.errorDescription!.contains("timed out") {
                        reply = .timeout
                    } else {
                        reply = LCAPINetworkStatus.failed
                    }
                    semaphore.signal()
                    return
                }

                reply = LCAPINetworkStatus.success
        
                semaphore.signal()
            }
            
        }
        
        semaphore.wait()
        
        return reply
    }
        
    /// 下载图片预览图
    /*
    public func pictureThumbDownload(targetURL: String, downloadFinishHandler:@escaping  (Image) -> Void) {
        /*
        AF.request(targetURL).responseImage { response in
            
            if case .success(let image) = response.result {
                
                print(">>> AFImg Download Succeed: \(targetURL)")
                downloadFinishHandler(image)
                
            } else {
                print(">>> AFImg Download Failure...")
            }
        }

        */
        
    }
    */
    /// 下载原图
    public func pictureImageDownload() {
        
    }
    
    
}
/*let timeline_data = LSTimeline()
timeline_data.loadFromJSON(json: timeline_json)
return timeline_data*/
