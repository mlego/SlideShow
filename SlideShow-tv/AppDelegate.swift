// Copyright © 2019 mlego. All rights reserved.

import UIKit
import ShowEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var useCase: ShowEngine?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let controller = (window?.rootViewController as? ViewController) {
            useCase = ShowEngineUseCaseFactory().makeUseCase(output: controller, imageSize: ImageSize.full)
            controller.showEngine = useCase
            controller.start()
        }
        
        return true
    }
}

