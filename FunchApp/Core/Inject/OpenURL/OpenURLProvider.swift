//
//  OpenURL.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/25/24.
//

import UIKit

protocol OpenURLProviderType {
    func feedback() throws
    func appstore() throws
    func releaseNote() throws
}

final class OpenURLProvider: OpenURLProviderType {
    static let shared = OpenURLProvider()
    
    private init() {}
    
    func feedback() throws {
        try execute(urlString: LinkStringSet.feedback.rawValue)
    }
    
    func appstore() throws {
        try execute(urlString: LinkStringSet.appstore.rawValue)
    }
    
    func releaseNote() throws {
        try execute(urlString: LinkStringSet.releaseNote.rawValue)
    }
    
    private func execute(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw OpenURLError.error("Failed to convert string to URL")
        }
        guard UIApplication.shared.canOpenURL(url) else {
            throw OpenURLError.error("Failed to open URL")
        }
        UIApplication.shared.open(url)
    }
}
