//
//  AppDelegate.swift
//  pam-demo
//
//  Created by narongrit kanhanoi on 2/3/2564 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        try! Pam.initialize(launchOptions: launchOptions, enableLog: true)
        Pam.listen("onToken") { args in
            if let token = args["token"] {
                print("Token = ", token)
            }
        }

        return true
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Pam.setDeviceToken(deviceToken: deviceToken)
    }

    func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let isNotNotificationFromPAM = Pam.didReceiveRemoteNotification(userInfo: userInfo,
            fetchCompletionHandler: completionHandler)

        if isNotNotificationFromPAM {
            // handle your own notification
            completionHandler(.newData)
        }
    }

    func application(_: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        print("application open url")
        print(url)
        print(options)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
