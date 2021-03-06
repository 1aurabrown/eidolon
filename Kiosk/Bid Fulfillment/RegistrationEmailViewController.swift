import UIKit

class RegistrationEmailViewController: UIViewController, RegistrationSubController {

    @IBOutlet var emailTextField: TextField!
    @IBOutlet var confirmButton: ActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let bidDetails = self.navigationController?.fulfillmentNav().bidDetails {
            emailTextField.text = bidDetails.newUser.email

            RAC(bidDetails, "newUser.email") <~ emailTextField.rac_textSignal()

            let emailIsValidSignal = RACObserve(bidDetails.newUser, "email").map(stringIsEmailAddress)
            RAC(confirmButton, "enabled") <~ emailIsValidSignal
        }
        
        emailTextField.becomeFirstResponder()
    }

    let finishedSignal = RACSubject()
    @IBAction func confirmTapped(sender: AnyObject) {
        finishedSignal.sendCompleted()
    }
}
