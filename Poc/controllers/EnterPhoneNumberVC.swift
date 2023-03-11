//


import UIKit

class EnterPhoneNumberVC: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var countryCodeTxtField: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    var phNumber : String?
    var isSuccess : Bool = false
    let apiViewModel = ApiViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        phoneNumberTextfield.delegate = self
        countryCodeTxtField.delegate = self
        setupUI()
       
    }
    
    func setupUI(){
        countryCodeTxtField.delegate = self
        phoneNumberTextfield.delegate = self
        countryCodeTxtField.layer.borderWidth = 1
        phoneNumberTextfield.layer.borderWidth = 1
        countryCodeTxtField.layer.borderColor = UIColor.lightGray.cgColor
        countryCodeTxtField.layer.cornerRadius = 8
        phoneNumberTextfield.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumberTextfield.layer.cornerRadius = 8
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
       phoneNumberTextfield.endEditing(true)
        return true
    }
    
   
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    
    
    @IBAction func btnContinueAction(_ sender: Any) {
        
        if let prefixHhNumber = countryCodeTxtField.text, let phNumberData = phoneNumberTextfield.text {
             phNumber = prefixHhNumber + phNumberData
    
            apiViewModel.postNumberData(phNumber: phNumber!){ result in
                switch result {
                case .success(let response):
                    print("status \(response.status!)")
                    if response.status == true {
                    self.isApicallSuccess()
                    }else {
                        self.isStatusFalse()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    func isApicallSuccess (){
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnterOtpVC") as! EnterOtpVC
            vc.phoneNumber = self.phNumber
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func isStatusFalse() {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Enter PhoneNumber", message: "Please enter valid number", preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
           }
           
           alertController.addAction(okAction)
           
           self.present(alertController, animated: true, completion: nil)
    }
}
}
