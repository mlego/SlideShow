// 

import WatchKit
import Foundation
import ShowEngine

class Model {
    let image: UIImage
    
    init(from model: ShowEngineModel) {
        if let imageData = model.imageData,
            let anImage = UIImage(data: imageData) {
            image = anImage
        } else {
            image = UIImage(named: "sadFace") ?? UIImage()
        }
    }
}

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
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.setImage($0)
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
    }
    
    public func imageLoadFailure() {
        viewModel?.image.value = UIImage(named: "sadFace") ?? UIImage()
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
