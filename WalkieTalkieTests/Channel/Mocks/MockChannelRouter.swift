//
//  MockChannelRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelRouter: ChannelRouterProtocol {
    var navigateToListUsersCalled = false
    var listUsersChannelName: String?

    func navigateToListUsers(from view: any WalkieTalkie.ChannelViewProtocol, with channelName: String) {
        navigateToListUsersCalled = true
        listUsersChannelName = channelName
    }
    
    var presentModalCalled = false
    var navigateToSettingsCalled = false
    var navigateToChannelPrivateCreateCalled = false

    static func createModule(with channel: WalkieTalkie.Channel?) -> UIViewController {
        return UIViewController()
    }
        
    func presentChannelsModally(from view: ChannelViewProtocol) {
        presentModalCalled = true
    }

    func navigateToChannelPrivateCreate(from view: ChannelViewProtocol) {
        navigateToChannelPrivateCreateCalled = true
    }
    
    func navigateToSettings(from view: ChannelViewProtocol) {
        navigateToSettingsCalled = true
    }
}
