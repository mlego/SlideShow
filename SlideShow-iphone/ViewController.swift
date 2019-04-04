// 

import UIKit
import ShowEngine

class ViewController: UIViewController {
    
    var showEngine: ShowEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEngine = ShowEngine(imageSize: .regular)
        
        if let engine = showEngine {
            engine.start()
        }
    }
}
