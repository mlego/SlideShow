// 

import Cocoa
import ShowEngine

class ViewModel {
    let image = Observable<NSImage>(value: NSImage())
}

class ViewController: NSViewController, ShowEngineOutput {

    var showEngine: ShowEngine?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] image in
            self?.outputImageView.image = image
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        if let imageData = data.imageData,
            let image = NSImage(data: imageData) {
            viewModel?.image.value = image
        }
    }
    
    public func imageLoadFailure() {
        
    }
    
    func start() {
        showEngine?.start()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

