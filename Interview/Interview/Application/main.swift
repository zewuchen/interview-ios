//
//  main.swift
//  Interview
//
//  Created by Rafael Ramos on 08/09/24.
//

import Foundation
import UIKit

func getAplicationDelegateFromMainTargetOrTestingTarget() -> AnyClass {
    return NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
}

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(getAplicationDelegateFromMainTargetOrTestingTarget())
)
