//
//  LCThread.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/21.
//
//

import Foundation
import SwiftyJSON

open class LSForumList : NSObject {
    
    public var forumListID: UInt = 0
    public var forumListSort: UInt = 0
    public var forumListName: String = ""
    public var forumStatus: String = ""
    public var forums: Array<LSForum> = []
    
    public func loadFromJSON(json: JSON) {
        
        forumListID = json["id"].uInt ?? 0
        
        for (_ ,subForums) in json["forums"] {
            let f = LSForum()
            f.loadFromJSON(json: subForums)
            forums.append(f)
        }
    }
    
    override open var description: String {
        return "LSForumList / id: \(forumListID), listSort: \(forumListSort), listName: \(forumListName), status: \(forumListName), forums: \(forums.description)"
    }
}

open class LSForum : NSObject {
    
    public var forumID: UInt = 0
    public var forumGroup: UInt = 0
    public var forumSort: UInt = 0
    public var forumName: String = ""
    public var forumShowName: String = ""
    public var forumMsg: String = ""
    public var forumInterval: UInt = 0
    public var forumSafeMode: UInt = 0
    public var forumAutoDelete: UInt = 0
    public var forumThreadCount: UInt = 0
    public var forumPermissionLevel: UInt = 0
    public var forumFuseID: UInt = 0
    public var forumCreatedAt: String = ""
    public var forumUpdatedAt: String = ""
    public var forumStatus: String = ""
    
    public func loadFromJSON(json: JSON) {
        forumID = UInt(json["id"].string ?? "0") ?? 0
        forumGroup = UInt(json["fgroup"].string ?? "0") ?? 0
        forumSort = UInt(json["sort"].string ?? "0") ?? 0
        forumName = json["name"].string ?? ""
        forumShowName = json["showName"].string ?? ""
        forumMsg = json["msg"].string ?? ""
        forumInterval = UInt(json["interval"].string ?? "0") ?? 0
        forumSafeMode = UInt(json["safe_mode"].string ?? "0") ?? 0
        forumAutoDelete = UInt(json["auto_delete"].string ?? "0") ?? 0
        forumThreadCount = UInt(json["thread_count"].string ?? "0") ?? 0
        forumPermissionLevel = UInt(json["permission_level"].string ?? "0") ?? 0
        forumFuseID = UInt(json["forum_fuse_id"].string ?? "0") ?? 0
        forumCreatedAt = json["createdAt"].string ?? ""
        forumUpdatedAt = json["updateAt"].string ?? ""
        forumStatus = json["status"].string ?? ""
    }
    
    override open var description: String {
        return "LSForum / id: \(forumID), group: \(forumGroup), sort: \(forumSort), name: \(forumName), showName: \(forumShowName), msg: \(forumMsg), interval: \(forumInterval), safeMode: \(forumSafeMode), autoDelete: \(forumAutoDelete), threadCount: \(forumThreadCount), permissionLevel: \(forumPermissionLevel), fuseID: \(forumFuseID), createdAt: \(forumCreatedAt), updatedAt: \(forumUpdatedAt), forumStatus: \(forumStatus)"
    }
    
}

open class LSTimelineList : NSObject {
    
    public var timelineList: Array<LSTimeline> = []
    
    public func loadFromJSON(json: JSON) {
       
        for (_, timeline_json) in json {
            
            let timeline = LSTimeline()
            timeline.loadFromJSON(json: timeline_json)
            self.timelineList.append(timeline)
        }
    }
    
    override open var description: String {
        return "LSTimelineList / list: \(timelineList)"
    }
}

open class LSTimeline : NSObject {
    
    public var timelineID: UInt = 0
    public var timelineName: String = ""
    public var timelineDisplayName: String = ""
    public var timelineNotice: String = ""
    public var timelineMaxpage: UInt = 0
    
    public func loadFromJSON(json: JSON) {
        timelineID = json["id"].uInt ?? 0
        timelineName = json["name"].string ?? ""
        timelineDisplayName = json["display_name"].string ?? ""
        timelineName = json["notice"].string ?? ""
        timelineMaxpage = json["max_page"].uInt ?? 0
    }
    
    override open var description: String {
        return "LSTimeline / id: \(timelineID), name: \(timelineName), displayName: \(timelineDisplayName), notice: \(timelineNotice), maxPage: \(timelineMaxpage)"
    }
    
}


open class LSThread : NSObject {
    
    public var threadID: UInt = 0
    public var threadForumID: UInt = 0
    public var threadReplyCount: UInt = 0
    
    public var threadImg: String = ""
    public var threadExt: String = ""
    public var threadDate: String = ""
    public var threadUserHash: String = ""
    public var threadName: String = ""
    public var threadTitle: String = ""
    public var threadContent: String = ""
    public var threadSage: Int = 0
    public var threadAdmin: Int = 0
    public var threadHide: Int = 0
    public var threadReplies: Array<LSThread> = []
    public var threadRemainReplies: UInt = 0
    
    public var threadIsReply: Bool = false
    
    override open var description: String {
        return "LSThread * id: \(threadID), forumID: \(threadForumID), replyConunt: \(threadReplyCount), img: \(threadImg), ext: \(threadExt), date: \(threadDate), userHash: \(threadUserHash), name: \(threadName), title: \(threadTitle), content: \(threadContent), sage: \(threadSage), admin: \(threadAdmin), hide: \(threadHide), remainReplies: \(threadRemainReplies), isReply: \(threadRemainReplies), replies: \(threadReplies)"
    }
    
    /// 富文本形式的帖子内容：Deprecated -> 使用 LSParser 转换富文本显示
    // public var threadContentAttributedString: NSMutableAttributedString? = nil
    
    public func loadFromJSON(json: JSON) {
        
        threadID = json["id"].uInt ?? 0
        threadForumID = json["fid"].uInt ?? 0
        threadReplyCount = json["ReplyCount"].uInt ?? 0
        threadImg = json["img"].string ?? ""
        threadExt = json["ext"].string ?? ""
        threadDate = json["now"].string ?? ""
        threadUserHash = json["user_hash"].string ?? ""
        threadName = json["name"].string ?? ""
        threadTitle = json["title"].string ?? ""
        threadContent = json["content"].string ?? ""
        threadSage = json["sage"].int ?? 0
        threadAdmin = json["admin"].int ?? 0
        threadHide = json["Hide"].int ?? 0
        threadRemainReplies = json["RemainReplies"].uInt ?? 0
        
        // 加载 Replies
        if (threadIsReply) {
            return
        }
        
        for (_, subJson) in json["Replies"] {
            let rp = LSThread()
            rp.threadIsReply = true
            rp.loadFromJSON(json: subJson)
            threadReplies.append(rp)
        }
    }
}

open class LSPost: NSObject {
    
    public var postName: String = ""
    public var postTitle: String = ""
    public var postContent: String = ""
    public var postForumID: UInt = 0
    public var postImage: Data = Data()
    public var postWater: Bool = false
    
}


open class LSOfficialNotice : NSObject {
    
    
    public var noticeContent: String = ""
    public var noticeDate: UInt = 0
    public var noticeEnabled: Bool = false
    
}
