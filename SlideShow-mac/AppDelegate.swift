// Copyright © 2019 mlego. All rights reserved.

import Cocoa
import ShowEngine

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var useCase: ShowEngine?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NSApplication.shared.keyWindow?.setFrame(NSRect(x: 0, y: 0, width: 800, height: 800), display: true )
        NSApplication.shared.keyWindow?.center()
        
        if let controller = NSApplication.shared.keyWindow?.contentViewController as? ViewController {

            useCase = ShowEngineUseCaseFactory().makeUseCase(output: controller, imageSize: ImageSize.full)
            controller.showEngine = useCase
            controller.start()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
