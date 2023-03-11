
import UIKit

class EnterOtpVC: UIViewController {
    
    @IBOutlet weak var optTxtfield: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    let apiViewModel = ApiViewModel()
    var phoneNumber : String?
    var myTabBarController: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        optTxtfield.layer.borderWidth = 1
        optTxtfield.layer.borderColor = UIColor.lightGray.cgColor
        optTxtfield.layer.cornerRadius = 8
        self.phoneNumberLabel.text  = phoneNumber
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if let otpNumber = optTxtfield.text {
            apiViewModel.postOTPData (phNumber: phoneNumber!, otpNumber: otpNumber) { result in
                switch result {
                case .success(let response):
                    print("response \(response)")
                    UserDefaults.standard.set(response.token ?? "", forKey: "token")
                    if response.token != nil {
                    self.isApiCallSuccess()
                    } else {
                        self.isTokenNil()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func isApiCallSuccess(){
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController

              // Set the TabBarController as the root view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = tabBarController
                    sceneDelegate.window?.makeKeyAndVisible()
            }
            self.myTabBarController = tabBarController
        }

//        DispatchQueue.main.async {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") as! NotesVC
//            self.present(vc, animated: true, completion: nil)
//
//        }
    }
    func isTokenNil() {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Enter Otp", message: "Please enter valid OTP", preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
           }
           
           alertController.addAction(okAction)
           
           self.present(alertController, animated: true, completion: nil)
    }
}
    
}




