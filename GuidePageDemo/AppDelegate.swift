//
//  AppDelegate.swift
//  GuidePageDemo
//
//  Created by goWhere on 2017/2/27.
//  Copyright © 2017年 iwhere. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  
    fileprivate let guideVC = UIStoryboard(name: "GuidePage", bundle: nil).instantiateViewController(withIdentifier: "GuideViewController") as? GuideViewController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        if isFirstLaunchOrUpdated() {
            // 首次打开或者更新后打开
            window?.rootViewController = guideVC
        } else {
            // 已经打开过，然后判断是否已经登录过
            if mUserDefaultsObject(kUserName) != nil && mUserDefaultsObject(kPassword) != nil {
                let mainVC = mViewControllerByStoryboard(sb: "Main", vc: "ViewController")
                window?.rootViewController = mainVC
            } else {
                let loginVC = mViewControllerByStoryboard(sb: "LoginAndRegister", vc: "LoginViewController") as! LoginViewController
                window?.rootViewController = loginVC
            }
        }

        window?.makeKeyAndVisible()
        setupLaunchImage()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    /// 动态启动图
    fileprivate func setupLaunchImage() {
        let launchSB = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "launchScreen")
        let launchView = launchSB.view
        window?.addSubview(launchView!)
        
        showGuidePage(0.5)
        
        // 动画效果
        UIView.animate(withDuration: 1.5, animations: {
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
            
        }) { (success) in
            launchView?.removeFromSuperview()
        }
    }
    
    /// 展示引导页
    ///
    /// - Parameter animationAfter: 延时动画时间
    private func showGuidePage(_ animationAfter: TimeInterval) {
        
        // 判断是否是首次启动或者更新后启动 ---- 暂时处理首次启动
        guard isFirstLaunchOrUpdated() == true else {
            return
        }

        // 将引导页设置为主页面
        let guideView = guideVC?.view
        window?.addSubview(guideView!)
        guideView?.alpha = 0.5
        
        
        // 延时加载动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationAfter) {
            UIView.animate(withDuration: 1.0) {
                guideView?.alpha = 1.0
            }
        }
    }
    
    /// 是否是首次登陆或者版本更新
    ///
    /// - Returns: 判断是否要展示引导页
    fileprivate func isFirstLaunchOrUpdated() -> Bool {
        // 获取应用上次启动时保存的版本号
        let lastVersion = UserDefaults.standard.object(forKey: kAppVersion) as? String
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
        
        if lastVersion == nil || lastVersion != currentVersion {
            // 未保存版本号或者已更新
            UserDefaults.standard.set(currentVersion, forKey: kAppVersion)
            UserDefaults.standard.synchronize()
            return true
        } else {
            return false
        }
    }
}

