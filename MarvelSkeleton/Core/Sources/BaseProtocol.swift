import UIKit

protocol ViewProtocol: AnyObject {
}

typealias BaseProtocol = BaseStoryboard & ViewProtocol

open class BaseNavigationController: UINavigationController, BaseProtocol, UINavigationControllerDelegate {
    open override var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? true
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? .all
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }

    open class var storyboardName: String {
        assertionFailure("Not implemented for \(sceneIdentifier)")
        return ""
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

open class BaseTabBarController: UITabBarController, BaseProtocol {
    open class var storyboardName: String {
        assertionFailure("Not implemented for \(sceneIdentifier)")
        return ""
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
