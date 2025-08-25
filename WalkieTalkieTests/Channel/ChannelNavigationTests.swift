//
//  ChannelNavigationTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelNavigationTests: XCTestCase {
    var channelVC: ChannelViewController!
    var presenter: ChannelPresenter!
    var router: ChannelRouter!
    var mockInteractor: MockChannelInteractor!
    
    override func setUp() {
        super.setUp()
        
        let channel = Channel(name: "General")
        channelVC = ChannelRouter.createModule(with: channel) as? ChannelViewController
        
        presenter = channelVC.presenter as? ChannelPresenter
        router = presenter.router as? ChannelRouter
        
        mockInteractor = MockChannelInteractor()
        presenter.interactor = mockInteractor
        router.viewController = channelVC
    }
    
    func testPresentChannelsModally() {
        let window = UIWindow()
        window.rootViewController = channelVC
        window.makeKeyAndVisible()
        
        presenter.didTapDropdown()
                
        XCTAssertNotNil(channelVC.presentedViewController)
        XCTAssertTrue(channelVC.presentedViewController is UINavigationController)
        
        let nav = channelVC.presentedViewController as! UINavigationController
        XCTAssertTrue(nav.viewControllers.first is ChannelsViewController)
    }
    
    func testSelectingChannelReplacesCurrent() {
        let window = UIWindow()
        window.rootViewController = channelVC
        window.makeKeyAndVisible()
        
        presenter.didTapDropdown()
        
        let nav = channelVC.presentedViewController as! UINavigationController
        let channelsVC = nav.viewControllers.first as! ChannelsViewController
        let channelsPresenter = channelsVC.presenter as! ChannelsPresenter
        
        let newChannel = Channel(name: "Random")
        channelsPresenter.onChannelSelected?(newChannel)
        
        XCTAssertTrue(mockInteractor.disconnectCalled)
    }
}
