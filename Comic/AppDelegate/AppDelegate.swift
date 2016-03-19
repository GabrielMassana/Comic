//
//  AppDelegate.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack
import CoreOperation

let NetworkDataOperationQueueTypeIdentifier: String = "NetworkDataOperationQueueTypeIdentifier"
let LocalDataOperationQueueTypeIdentifier: String = "LocalDataOperationQueueTypeIdentifier"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CDFCoreDataManagerDelegate {

    //MARK: - Accessors

    var window: UIWindow? = {
        
        let window: UIWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        
        return window
    }()

    var rootNavigationController: RootNavigationController = RootNavigationController()
    
     //MARK: - UIApplicationDelegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        CDFCoreDataManager.sharedInstance().delegate = self

        /*-------------------*/
        
        registerOperationQueues()
        
        /*-------------------*/
        
        window!.rootViewController = rootNavigationController
        window!.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    //MARK: - OperationQueues
    
    func registerOperationQueues() {
        
        let networkDataOperationQueue:NSOperationQueue = NSOperationQueue()
        networkDataOperationQueue.qualityOfService = .Background
        networkDataOperationQueue.maxConcurrentOperationCount = 1
        COMOperationQueueManager.sharedInstance().registerOperationQueue(networkDataOperationQueue, operationQueueIdentifier: NetworkDataOperationQueueTypeIdentifier)
        
        let localDataOperationQueue:NSOperationQueue = NSOperationQueue()
        localDataOperationQueue.qualityOfService = .Background
        localDataOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount
        COMOperationQueueManager.sharedInstance().registerOperationQueue(localDataOperationQueue, operationQueueIdentifier: LocalDataOperationQueueTypeIdentifier)
    }
    
    //MARK: - CDFCoreDataManagerDelegate
    
    internal func coreDataModelName() -> String! {
        
        return "Marvel"
    }
}
