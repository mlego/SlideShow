//

import UIKit
import ShowEngine

final class Model {
    fileprivate let photographer: String
    fileprivate let location: String
    fileprivate let likes: String
    fileprivate let image: UIImage
    
    init(from model: ShowEngineModel) {
        photographer = "Photographer: \(model.user.name ?? " Unknown")"
        location = "Location: \(model.user.location ?? "Anywhere")"
        likes = "Likes: \(model.likes ?? 0)"
        
        if let imageData = model.imageData,
            let anImage = UIImage(data: imageData) {
                image = anImage
        } else {
            image = UIImage(named: "sadFace") ?? UIImage()
        }
    }
}

final class ViewModel {
    fileprivate let image = Observable<UIImage>(value: UIImage())
    fileprivate let location = Observable<String>(value: String())
    fileprivate let likes = Observable<String>(value: String())
    fileprivate let photographer = Observable<String>(value: String())
}

final class ViewController: UIViewController, ShowEngineOutput {
    
    var showEngine: ShowEngineInput?
    private var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.image = $0
        }
        
        viewModel?.location.addObserver { [weak self] in
            self?.locationLabel.text = $0
        }
        
        viewModel?.likes.addObserver { [weak self] in
            self?.likesLabel.text = $0
        }
        
        viewModel?.photographer.addObserver { [weak self] in
            self?.photographerLabel.text = $0
        }
    }
    
    func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
        viewModel?.location.value = myModel.location
        viewModel?.likes.value = myModel.likes
        viewModel?.photographer.value = myModel.photographer
    }
    
    func imageLoadFailure() {
        viewModel?.image.value = UIImage(named: "sadFace") ?? UIImage()
    }
    
    func start() {
        showEngine?.start()
    }
    
    func stop() {
        showEngine?.stop()
    }
}
