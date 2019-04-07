// 

import UIKit
import ShowEngine

class ViewModel {
    let image = Observable<UIImage>(value: UIImage())
}

class ViewController: UIViewController, ShowEngineOutput {

    var showEngine: ShowEngine?
    var viewModel: ViewModel?
    var dataProvider: ShowEngineInput
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel?.image.addObserver { [weak self] image in
            self?.outputImage.image = image
        }
        
//        showEngine = ShowEngine(imageSize: .full)
//
//        if let engine = showEngine {
//            engine.start()
//        }
    }
    
    func imageLoaded(data: TestImageData?) {
        if let imageData = data, let image = UIImage(data: imageData.image) {
            viewModel?.image.value = image
        } else {
            
        }
    }
}
