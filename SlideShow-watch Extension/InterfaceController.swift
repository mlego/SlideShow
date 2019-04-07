// 

import WatchKit
import Foundation
import ShowEngine

class ViewModel {
    let image = Observable<UIImage>(value: UIImage())
}

class InterfaceController: WKInterfaceController, ShowEngineOutput {

    var showEngine: ShowEngineInput?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] image in
            self?.outputImageView.setImage(image)
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        if let imageData = data.imageData,
            let image = UIImage(data: imageData) {
            viewModel?.image.value = image
        }
    }
    
    public func imageLoadFailure() {
        
    }
    
    func start() {
        showEngine?.start()
    }
    
    func stop() {
        showEngine?.stop()
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
