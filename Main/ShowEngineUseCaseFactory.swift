// 

import Foundation
import ShowEngine

final class ShowEngineUseCaseComposer: ShowEngineOutput {
    
    let outputs: [ShowEngineOutput]
    
    public init(_ outputs: [ShowEngineOutput]) {
        self.outputs = outputs
    }
    
    public func imageLoadSuccess(data: ShowEngineModel) {
        outputs.forEach { $0.imageLoadSuccess(data: data) }
    }
    
    public func imageLoadFailure() {
        outputs.forEach { $0.imageLoadFailure() }
    }
}

final class ShowEngineUseCaseFactory {
    
    public func makeUseCase(output: ShowEngineOutput, imageSize: ImageSize) -> ShowEngine {
        return ShowEngine(output: ShowEngineUseCaseComposer([output]), imageSize: imageSize)
    }
}
