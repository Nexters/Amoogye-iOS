//
//  OnboardingViewController.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class OnboardingViewController: UIViewController {
    @IBOutlet weak var titleView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!

    var scrollWidth: CGFloat = 0.0
    var scrollHeight: CGFloat = 0.0

    var pageDataList = OnboardingData.contents()
    var pageViewList = [ContentsDelegate]()

    var currentPage: Int {
        get {
            return Int(scrollView.contentOffset.x/scrollWidth)
        }
    }

    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layoutIfNeeded()

        setup()
    }

    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
}

// MARK: - Setup 함수
extension OnboardingViewController {
    func setup() {
        setupTitleView()
        setupScrollView()
        setupPageContents()
        setupPageControl()
        setupStartButton()
    }

    private func setupTitleView() {
        titleView.image = UIImage(named: "amoogye")
    }

    private func setupScrollView() {
        self.scrollView.delegate = self

        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.bounces = false
    }

    private func setupPageContents() {
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<pageDataList.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)
            let pageData = pageDataList[index]

            switch pageData.type {
            case .lottie:
                let pageView = LottiePageView(frame: frame)

                pageView.setup(contentView: slide, filename: pageData.filename, endFrame: pageData.endFrame, repeatFrame: pageData.repeatFrame, title: pageData.title, description: pageData.description)

                self.pageViewList.append(pageView)

            case .video:
                let pageView = VideoPageView(frame: frame)

                pageView.setup(contentView: slide, filename: pageData.filename, title: pageData.title, description: pageData.description)

                self.pageViewList.append(pageView)
            }

            scrollView.addSubview(slide)
        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(pageDataList.count), height: 1.0)

        setContentsPlaying()
    }

    private func setupPageControl() {
        pageControl.numberOfPages = pageDataList.count
        pageControl.currentPage = 0
    }

    private func setupStartButton() {
        self.startButton.layer.cornerRadius = 6
        self.startButton.isHidden = true
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if pageControl?.currentPage != currentPage {
            setIndiactorForCurrentPage()
            setStartButtonForCurrentPage()
            setContentsPlaying()
        }
    }

    private func setIndiactorForCurrentPage() {
        pageControl?.currentPage = currentPage
    }

    private func setStartButtonForCurrentPage() {
        if currentPage == pageDataList.count - 1 {
            self.startButton.isHidden = false
            return
        }
        self.startButton.isHidden = true
    }

    private func setContentsPlaying() {
        for page in pageViewList {
            page.stop()
        }

        pageViewList[currentPage].play()
    }
}
