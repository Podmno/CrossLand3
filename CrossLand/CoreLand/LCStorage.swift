//
//  LCStorage.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/28.
//

import Foundation

/// 存储器与缓存管理
open class LCStorage : NSObject {
    
    /// 全局共享的存储器资源
    static let shared = LCStorage()
    
    let defaultsUtil = LCDefaults()
    
    /// CDN 镜像 URL
    var cdnUrl: String = ""
    
    var userDocumentsDirectory = ""
    
    var userTemporaryDirectory = ""
    
    public override init() {
        super.init()
        
        print("LCStorage >> Init Process...")
        
        let target_documents_dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        print("LCStorage >> User Documents Dir: " + target_documents_dir)
        let target_tmp_dir = NSTemporaryDirectory()
        print("LCStorage >> Temporary Directory: " + target_tmp_dir)
        
        userDocumentsDirectory = target_documents_dir + "/"
        userTemporaryDirectory = target_tmp_dir
    }
    
    public func globalSaveForumListData(forumJson: String) {
        
    }
    
    public func globalSaveCDNImageURL(cdnUrl: String) {
        print("GlobalConfig > CDN Image Url Updated \(cdnUrl)")
        self.cdnUrl = cdnUrl
    }
        
    public func getCDNImageURL() -> String {
        return cdnUrl
    }
    
    public func getForumNameByID(fid: UInt) {
        
        
        
    }
    
    public func getTimlineNameByID(tid: UInt) {
        
        
        
    }
    

    
}


open class LCStoragePictureStack : NSObject {
    
    
    /// 将图片资料保存至本地缓存
    private func savePictureToDisk() {
        
        
    }
    
    
    /// 本地图片读取
    private func loadPictureFromDisk() {
        
        
        
    }
    
    /// 根据加载策略从本地加载图片数据
    private func loadDiskPictureIndexData() {
        
    }
    
}
