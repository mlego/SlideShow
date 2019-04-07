//

import UIKit
import ShowEngine

class ViewModel {
    let image = Observable<UIImage>(value: UIImage())
}

class ViewController: UIViewController, ShowEngineOutput {
    
    var showEngine: ShowEngineInput?
    var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] image in
            self?.outputImageView.image = image
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
}
