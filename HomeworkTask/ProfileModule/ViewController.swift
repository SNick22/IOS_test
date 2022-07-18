//
//  ViewController.swift
//  HomeworkTask
//
//  Created by Азат Абдрахманов on 18.07.2022.
//

import UIKit

class Profile: NSObject, NSCoding {
    
    let email: String
    var password: String
    let firstName: String
    let lastName: String
    let imageName: String
    
    init(email: String, password: String, firstName: String, lastName: String, imageName: String) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.imageName = imageName
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(imageName, forKey: "imageName")
    }
    
    required init?(coder: NSCoder) {
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
        firstName = coder.decodeObject(forKey: "firstName") as? String ?? ""
        lastName = coder.decodeObject(forKey: "lastName") as? String ?? ""
        imageName = coder.decodeObject(forKey: "imageName") as? String ?? ""
    }
}

// MARK: - Properties

let profiles: [Profile] = [
    Profile(email: "email1@gmail.com", password: "qwert12PO", firstName: "Stas", lastName: "Ivanov", imageName: "1"),
    Profile(email: "email2@gmail.com", password: "qwert12PO", firstName: "Pasha", lastName: "Ivanov", imageName: "2"),
    Profile(email: "email3@gmail.com", password: "qwert12PO", firstName: "Vlad", lastName: "Ivanov", imageName: "3")
]

class ViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    
    // MARK: - View file cycle
    
    override func viewWillAppear(_ animated: Bool) {
        if ProfileData.profile != nil {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
            
            profileVC.email = ProfileData.profile.email
            profileVC.firstName = ProfileData.profile.firstName
            profileVC.lastName = ProfileData.profile.lastName
            profileVC.imgName = ProfileData.profile.imageName
            
            profileVC.modalPresentationStyle = .fullScreen
            present(profileVC, animated: false, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Youremail@gmail.com"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
    }
    
    
    // MARK: - Actions
    
    @IBAction func signInDidTab(_ sender: UIButton) {

        guard let emailTextField = emailTextField.text  else { return }
        guard let passwordTextField = passwordTextField.text  else { return }
        let data = getProfile(email: emailTextField)
        
        if emailTextField.isValidEmail() == true && passwordTextField.isValidPassword() == true {
            if isPasswordExist() && isEmailExist() {
                
                let user = data.0
                let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                
                guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
                
                profileVC.email = user.email
                profileVC.firstName = user.firstName
                profileVC.lastName = user.lastName
                profileVC.imgName = user.imageName
                
                ProfileData.profile = user
                profileVC.modalPresentationStyle = .fullScreen
                present(profileVC, animated: true, completion: nil)
            } else {
                appearAlert()
            }
        } else {
            appearAlert()
        }
    }
    
    func appearAlert() {
        let alert = UIAlertController(title: "error", message: "No access due to incorrectly entered data", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okButton)
        passwordTextField.text = ""
        emailTextField.text = ""
        present(alert, animated: true, completion: nil)
    }
    
    func isPasswordExist() -> Bool {
        var flag = false
        for curProfile in profiles {
            if curProfile.password == passwordTextField.text {
                flag = true
            }
        }
        return flag
    }
    
    func isEmailExist() -> Bool {
        var flag = false
        for curProfile in profiles {
            if curProfile.email == emailTextField.text {
                flag = true
            }
        }
        return flag
    }
    
    func getProfile(email: String) -> (Profile, Bool){
        // Наличие пользователя в массиве
        for profile in profiles {
            if profile.email == email{
                return (profile, true)
            }
        }
        return (Profile(email: "", password: "", firstName: "", lastName: "", imageName: ""), false)
    }
}



extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailCheck = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailCheck.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
}

