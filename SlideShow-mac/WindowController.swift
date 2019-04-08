// Copyright © 2019 mlego. All rights reserved.

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func windowWillClose(_ notification: Notification) {
        (window?.contentViewController as? ViewController)?.stop()
    }
}
