// 

import Cocoa
import ShowEngine

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = ShowEngine() { print($0 ?? "") }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

