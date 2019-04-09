// Copyright © 2019 mlego. All rights reserved.

import WatchKit
import Foundation
import ShowEngine

final class Model {
    fileprivate let image: UIImage
    
    init(from model: ShowEngineModel) {
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
}

final class InterfaceController: WKInterfaceController, ShowEngineOutput {

    weak var showEngine: ShowEngineInput?
    private var viewModel: ViewModel?
    
    @IBOutlet weak var outputImageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        viewModel = ViewModel()
        viewModel?.image.addObserver { [weak self] in
            self?.outputImageView.setImage($0)
        }
    }
    
    func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
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
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
