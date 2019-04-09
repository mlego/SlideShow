// Copyright © 2019 mlego. All rights reserved.

import UIKit
import ShowEngine

final class Model {
    fileprivate let photographer: String
    fileprivate let location: String
    fileprivate let image: UIImage
    fileprivate let description: String
    
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

final class ViewModel {
    fileprivate let image = Observable<UIImage>(value: UIImage())
    fileprivate let imageDescription = Observable<String>(value: String())
    fileprivate let location = Observable<String>(value: String())
    fileprivate let photographer = Observable<String>(value: String())
}

final class ViewController: UIViewController, ShowEngineOutput {

    weak var showEngine: ShowEngine?
    private var viewModel: ViewModel?
    
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
    
    func imageLoadSuccess(data: ShowEngineModel) {
        let myModel = Model(from: data)
        viewModel?.image.value = myModel.image
        viewModel?.location.value = myModel.location
        viewModel?.photographer.value = myModel.photographer
        viewModel?.imageDescription.value = myModel.description
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
