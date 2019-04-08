// 

import Foundation
import ShowEngine

final class ShowEngineUseCaseComposer: ShowEngineOutput {
    
    private let outputs: [ShowEngineOutput]
    
    init(_ outputs: [ShowEngineOutput]) {
        self.outputs = outputs
    }
    
    internal func imageLoadSuccess(data: ShowEngineModel) {
        outputs.forEach { $0.imageLoadSuccess(data: data) }
    }
    
    internal func imageLoadFailure() {
        outputs.forEach { $0.imageLoadFailure() }
    }
}

final class ShowEngineUseCaseFactory {
    
    internal func makeUseCase(output: ShowEngineOutput, imageSize: ImageSize) -> ShowEngine {
        return ShowEngine(output: ShowEngineUseCaseComposer([output]), imageSize: imageSize)
    }
}
