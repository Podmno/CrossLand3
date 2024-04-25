//
//  LCDefaults.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/29.
//

import Foundation

/// 软件偏好设置核心
open class LCDefaults : NSObject {
    /// Foundation 系统偏好管理
    let manager = UserDefaults.standard
    
    /// 设定首屏展示页面状态
    func setFirstInitDisplayDataStatus(status: Bool) {
        manager.setValue(status, forKey: "landX.firstInitDisplayDataStatus")
        
    }
    
    /// 获取是否展示初始化界面
    func loadFirstInitDisplayDataStatus() -> Bool {
        return manager.bool(forKey: "landX.firstInitDisplayDataStatus")
    }
    
    /// 设定用户 Cookie 列表
    func addUserCookieInfo() {
        
        
    }
    
    
    
    /// 全部恢复到默认配置
    func restoreDefaults() {
        manager.setValue(true, forKey: "landX.firstInitDisplayDataStatus")
    }
    
    
}
