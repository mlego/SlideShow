// 

import Cocoa
import ShowEngine

class Model {
    let callout: String
    let image: NSImage
    
    init(from model: ShowEngineModel) {
        var tempCallout = ""
        if let description = model.imageDescription, !description.isEmpty { tempCallout += description + " by "}
        if let name = model.user.name, !name.isEmpty { tempCallout += name }
        tempCallout += ". \(model.likes ?? 0) like(s)"
        callout = tempCallout
        
        if let imageData = model.imageData,
            let anImage = NSImage(data: imageData) {
            image = anImage
        } else {
            image = NSImage(named: "sadFace") ?? NSImage()
        }
    }
}

class ViewModel {
    let image = Observable<NSImage>(value: NSImage())
    let callout = Observable<String>(value: String())
}

class ViewController: NSViewController, ShowEngineOutput {

    var showEngine: ShowEngine?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: NSImageView!
    @IBOutlet weak var calloutLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.image = $0
        }
        
        viewModel?.callout.addObserver { [weak self] in
            self?.calloutLabel.stringValue = $0
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
        viewModel?.callout.value = myModel.callout
    }
    
    public func imageLoadFailure() {
        viewModel?.image.value = NSImage(named: "sadFace") ?? NSImage()
    }
    
    func start() {
        showEngine?.start()
    }
    
    func stop() {
        showEngine?.stop()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

