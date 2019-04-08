// 

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NSApplication.shared.keyWindow?.center()
        
        if let controller = NSApplication.shared.keyWindow?.contentViewController as? ViewController {

            let useCase = ShowEngineUseCaseFactory().makeUseCase(output: controller)
            controller.showEngine = useCase
            controller.start()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

