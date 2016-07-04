//
//  AppDelegate.swift
//  LayerDemo1
//
//  Created by sunyazhou on 16/7/4.
//  Copyright © 2016年 Baidu, Inc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    
    
    @IBOutlet weak var loadingView: BDLoadingView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.window.backgroundColor = NSColor.redColor()
        self.loadingView.layer?.backgroundColor = NSColor.cyanColor().CGColor
        self.loadingView.wantsLayer = true
        
        self.loadingView.beginComplexAnimation()

    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
        // Insert code here to tear down your application
            
    }
    
    



}

