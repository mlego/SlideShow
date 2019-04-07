//

import UIKit
import ShowEngine

class Model {
    let photographer: String
    let location: String
    let likes: String
    let image: UIImage
    
    init(orig: ShowEngineModel) {
        photographer = "Photographer: \(orig.user.name ?? " Unknowned")"
        location = "Location: \(orig.user.location ?? "Anywhere")"
        likes = "Likes \(orig.likes ?? 0)"
        
        if let imageData = orig.imageData,
            let anImage = UIImage(data: imageData) {
                image = anImage
        } else {
            image = UIImage(named: "")!
        }
    }
}

class ViewModel {
    let image = Observable<UIImage>(value: UIImage())
    let location = Observable<String>(value: String())
    let likes = Observable<String>(value: String())
    let photographer = Observable<String>(value: String())
}

class ViewController: UIViewController, ShowEngineOutput {
    
    var showEngine: ShowEngineInput?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] image in
            self?.outputImageView.image = image
        }
        
        viewModel?.location.addObserver { [weak self] text in
            self?.locationLabel.text = text
        }
        
        viewModel?.likes.addObserver { [weak self] text in
            self?.likesLabel.text = text
        }
        
        viewModel?.photographer.addObserver { [weak self] text in
            self?.photographerLabel.text = text
        }
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(orig: data)
        viewModel?.image.value = myModel.image
        viewModel?.location.value = myModel.location
        viewModel?.likes.value = myModel.likes
        viewModel?.photographer.value = myModel.photographer
    }
    
    public func imageLoadFailure() {
        
    }
    
    func start() {
        showEngine?.start()
    }
}
