//
//  PreviewUtil.swift
//

import Foundation

var isPreviewing: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

var isTesting: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
