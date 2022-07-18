//
//  ProfileData.swift
//  HomeworkTask
//
//  Created by Азат Абдрахманов on 18.07.2022.
//

import Foundation

final class ProfileData {
    private enum SettingKeys: String {
        case profile
    }
    
    static var profile: Profile! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingKeys.profile.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Profile else {return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKeys.profile.rawValue
            
            if let profile = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false){
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}
