import UIKit

// Unused ATM

class ConfirmYourBidPasswordViewController: UIViewController {

    @IBOutlet var bidDetailsPreviewView: BidDetailsPreviewView!

    class func instantiateFromStoryboard() -> ConfirmYourBidEnterYourEmailViewController {
        return UIStoryboard.fulfillment().viewControllerWithID(.ConfirmYourBid) as ConfirmYourBidEnterYourEmailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bidDetailsPreviewView.bidDetails = fulfillmentNav().bidDetails
    }
    
    @IBAction func dev_noPhoneNumberFoundTapped(sender: AnyObject) {

    }

}
