//
//  GiftModel.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import Foundation

struct GiftModel {
    // 礼物标识
    var tag: Int = -1
    
    /// 头像地址
    var headerUrl: String = ""
    
    /// 送出礼物用户名
    var userName: String = ""
    
    /// 接收礼物用户名
    var toUserName: String = ""
    
    /// 礼物 icon 地址
    var giftImageUrl: String = ""
    
    /// 数量
    var number: Int = 1
}
