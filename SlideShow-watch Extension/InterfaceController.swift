// 

import WatchKit
import Foundation
import ShowEngine

class InterfaceController: WKInterfaceController {

//    var showEngine: ShowEngine?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
//        showEngine = ShowEngine(imageSize: .small)
//
//        if let engine = showEngine {
//            engine.start()
//        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
