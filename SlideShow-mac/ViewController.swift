// 

import Cocoa
import ShowEngine

class ViewController: NSViewController {

    var showEngine: ShowEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEngine = ShowEngine(imageSize: .regular)
        
        if let engine = showEngine {
            engine.start()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

