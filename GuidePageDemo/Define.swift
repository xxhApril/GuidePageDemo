//
//  Define.swift
//  GuidePageDemo
//
//  Created by goWhere on 2017/2/27.
//  Copyright © 2017年 iwhere. All rights reserved.
//

import UIKit

// 本地保存版本号
public let kAppVersion = "appVersion"
// 本地账号
public let kUserName = "userName"
// 本地密码
public let kPassword = "password"


/// 从 Storyboard 中读取 ViewController
///
/// - Parameters:
///   - name: SB name
///   - identifier: VC identifier
/// - Returns: need VC
public func mViewControllerByStoryboard(sb name: String, vc identifier: String) -> UIViewController {
    return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
}
/// 设置 UserDefaults 值的存取
public func mUserDefaultsSetValue(_ value: Any, _ key: String) {
    UserDefaults.standard.set(value, forKey: key)
}
public func mUserDefaultsObject(_ key: String) -> Any? {
    return UserDefaults.standard.object(forKey: key)
}

