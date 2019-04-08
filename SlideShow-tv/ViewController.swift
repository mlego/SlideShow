// 

import UIKit
import ShowEngine

class Model {
    let photographer: String
    let location: String
    let image: UIImage
    let description: String
    
    init(from model: ShowEngineModel) {
        photographer = "\(model.user.name ?? " Unknown")"
        location = "\(model.user.location ?? "Anywhere")"
        description = "\(model.imageDescription ?? "")"
        
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
    let imageDescription = Observable<String>(value: String())
    let location = Observable<String>(value: String())
    let photographer = Observable<String>(value: String())
}

class ViewController: UIViewController, ShowEngineOutput {

    var showEngine: ShowEngine?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.image = $0
        }
        
        viewModel?.imageDescription.addObserver { [weak self] in
            self?.descriptionLabel.text = $0
        }
        
        viewModel?.location.addObserver { [weak self] in
            self?.locationLabel.text = $0
        }
        
        viewModel?.photographer.addObserver { [weak self] in
            self?.photographerLabel.text = $0
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
        viewModel?.location.value = myModel.location
        viewModel?.photographer.value = myModel.photographer
        viewModel?.imageDescription.value = myModel.description
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
}
