//
//  LoginViewController.swift
//  pam-demo
//
//  Created by narongrit kanhanoi on 2/3/2564 BE.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        overrideUserInterfaceStyle = .light
        
        emailField.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickEmail))
        emailField.addGestureRecognizer(gesture)
    }
    
    @objc func clickEmail() {
        let alert = UIAlertController(title: "Login With Email", message: "Select an email you want to login.", preferredStyle: .actionSheet)
        
        let mail1 = UIAlertAction(title: "a.email@pams.ai", style: .default, handler: {_ in
            self.emailField.text = "a.email@pams.ai"
        })
        
        let mail2 = UIAlertAction(title: "b.email@pams.ai", style: .default, handler: {_ in
            self.emailField.text = "b.email@pams.ai"
        })
        
        let mail3 = UIAlertAction(title: "c.email@pams.ai", style: .default, handler: {_ in
            self.emailField.text = "c.email@pams.ai"
        })
        
        alert.addAction(mail1)
        alert.addAction(mail2)
        alert.addAction(mail3)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Pam.askNotificationPermission(mediaAlias: "ios-noti", options:  [.alert, .sound, .badge])
       
        
        Pam.track(event: "pageview", payload: ["pageName":"test"])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func doLogin(email:String){
        if let user = MockAPI.main.login(email: email) {
            Pam.userLogin(custID: user.custID)
            
            AppData.main.loginUser = user
            gotoHome()
        }
    }
    
    func gotoHome() {
        let tabViewController = HomeTabbarController()
        navigationController?.setViewControllers([tabViewController], animated: true)
    }

    @IBAction func clickLogin(_ sender: Any) {
        let email = emailField.text ?? ""
        if email != "" {
            doLogin(email: email)
        }
    }
    
    
    @IBAction func clickSkipLogin(_ sender: Any) {
        gotoHome()
    }
    
    @IBAction func clickRegister(_ sender: Any) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            
            present(viewController, animated: true)
            viewController.onRegisterSuccess = { email in
                self.doLogin(email: email)
            }
        }
        
    }
    
    
}
