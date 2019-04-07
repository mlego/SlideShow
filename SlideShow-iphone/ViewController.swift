// 

import UIKit
import ShowEngine

class ViewController: UIViewController, ShowEngineOutput {
    
    var showEngine: ShowEngineInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        
    }
    
    public func imageLoadFailure() {
        
    }
    
    func start() {
        showEngine?.start()
    }
}
