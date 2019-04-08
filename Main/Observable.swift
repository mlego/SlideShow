// Copyright © 2019 mlego. All rights reserved.

import Foundation

final class Observable<T> {
    
    init(value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    var valueChanged: ((T) -> Void)?
    
    func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }
    
    func removeObserver() {
        valueChanged = nil
    }
}
