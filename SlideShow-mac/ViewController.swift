// 

import Cocoa
import ShowEngine

class Model {
    let photographer: String
    let location: String
    let likes: String
    let image: NSImage
    
    init(from model: ShowEngineModel) {
        photographer = "Photographer: \(model.user.name ?? " Unknown")"
        location = "Location: \(model.user.location ?? "Anywhere")"
        likes = "Likes: \(model.likes ?? 0)"
        
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
    let location = Observable<String>(value: String())
    let likes = Observable<String>(value: String())
    let photographer = Observable<String>(value: String())
}

class ViewController: NSViewController, ShowEngineOutput {

    var showEngine: ShowEngine?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.image = $0
        }
        
//        viewModel?.location.addObserver { [weak self] in
//            self?.locationLabel.text = $0
//        }
//
//        viewModel?.likes.addObserver { [weak self] in
//            self?.likesLabel.text = $0
//        }
//
//        viewModel?.photographer.addObserver { [weak self] in
//            self?.photographerLabel.text = $0
//        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
        viewModel?.location.value = myModel.location
        viewModel?.likes.value = myModel.likes
        viewModel?.photographer.value = myModel.photographer
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

