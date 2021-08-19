import UIKit

typealias State = Equatable

open class BaseViewController: UIViewController, BaseProtocol {
    open override var shouldAutorotate: Bool {
        true
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let isIphone = UIDevice.current.userInterfaceIdiom == .phone
        return isIphone ? .portrait : .all
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
    }
}
