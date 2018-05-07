//
//  SettingsRepository.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation

class SettingsRepository {
    public static var unsplashApiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "UnsplashApiClientId") as! String
    }
}
