import UIKit

class PresentationModalController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }

        let height: CGFloat = containerView.frame.height / 2.5
        let originY: CGFloat = containerView.frame.height - height

        return CGRect(x: 0, y: originY, width: containerView.frame.width, height: height)
    }
}
