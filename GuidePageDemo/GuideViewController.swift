//
//  GuideViewController.swift
//  GuidePageDemo
//
//  Created by goWhere on 2017/2/27.
//  Copyright © 2017年 iwhere. All rights reserved.
//

import UIKit

/// 屏幕宽高
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height


class GuideViewController: UIViewController {

    // MARK: - 👉Properties
    private let GuidePhotoNumber = 3
    @IBOutlet weak var viewCenterLayout: NSLayoutConstraint!
    @IBOutlet weak var viewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var viewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tasetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 更新布局
        viewTopLayout.constant = kScreenHeight - viewHeightLayout.constant

        setupScrollView()
        
    }

    // MARK: - 👉Private Methods
    
    /// 设置 ScrollView
    private func setupScrollView() {
        scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(GuidePhotoNumber), height: kScreenHeight)
        prepareShowGuideImageView(with: 0, imageName: "guide_1")
        prepareShowGuideImageView(with: kScreenWidth, imageName: "guide_2")
        prepareShowGuideImageView(with: 2 * kScreenWidth, imageName: "guide_3")
        
        // 登录视图
        viewCenterLayout.constant = viewCenterLayout.constant + kScreenWidth * ((CGFloat(GuidePhotoNumber) - 1))
        scrollView.bringSubview(toFront: tasetView)
        
        pageControl.numberOfPages = GuidePhotoNumber
        
    }
    
    /// 引导页图片
    ///
    /// - Parameters:
    ///   - originX: 坐标
    ///   - name: 图片名
    private func prepareShowGuideImageView(with originX: CGFloat, imageName name: String) {
        let imageView = UIImageView(frame: CGRect(x: originX, y: 0, width: kScreenWidth, height: kScreenHeight))
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        scrollView.addSubview(imageView)
    }
    
    
    @IBAction func beginAction(_ sender: UIButton) {
        
        // 已经打开过，然后判断是否已经登录过
        if mUserDefaultsObject(kUserName) != nil && mUserDefaultsObject(kPassword) != nil {
            let mainVC = mViewControllerByStoryboard(sb: "Main", vc: "ViewController")
            present(mainVC, animated: true, completion: nil)
        } else {
            let loginVC = mViewControllerByStoryboard(sb: "LoginAndRegister", vc: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }
    }

}


extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / kScreenWidth)
    }
}
