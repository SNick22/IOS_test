//
//  ProfileViewController.swift
//  HomeworkTask
//
//  Created by Азат Абдрахманов on 18.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var email = String()
    var firstName = String()
    var lastName = String()
    var imgName = String()
    
    // MARK: - UI
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            profileImage.layer.cornerRadius = 30
            profileImage.image = UIImage(named: imgName)
        }
    }
    @IBOutlet weak var profileEmailLabel: UILabel! {
        didSet{
            profileEmailLabel.text = email
        }
    }
    @IBOutlet weak var profileFirstNameLabel: UILabel! {
        didSet{
            profileFirstNameLabel.text = firstName
        }
    }
    @IBOutlet weak var profileLastNameLabel: UILabel! {
        didSet{
            profileLastNameLabel.text = lastName
        }
    }
    
    @IBAction func logOutDidTab(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey:"profile")
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
//
//        mainVC.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(mainVC,  animated: true)
        dismiss(animated: true)
    }
    
    // MARK: - View file cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
