//
//  Extensions.swift
//  Source
//
//  Created by Stefan Herold on 26.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

// MARK: - Auto-Layout Friendly View Adding

public extension UIView {

    func addMaximizedTo(_ parent: UIView, margins: UIEdgeInsets = .zero) {
        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: margins.left),
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -margins.right),
            topAnchor.constraint(equalTo: parent.topAnchor, constant: margins.top),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margins.bottom)
        ]

        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate(constraints)
    }

    func addTo(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
    }
}

// MARK: - Load Images from URL

extension UIImageView {

    private static var cache: [URL: UIImage] = [:]
    private static var session: URLSessionProtocol = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15.0
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()

    func setImage(from url: URL?,
                  placeholder: UIImage? = nil,
                  session: URLSessionProtocol? = nil,
                  didSetImage: @escaping (UIImage?) -> Void) {

        // Update session
        if let session = session {
            Self.session = session
        }

        // Try to find cached image
        if let url = url, let cachedImage = Self.cache[url] {
            self.image = cachedImage
            didSetImage(cachedImage)
            return
        }

        // Set image to placeholder or nil and report that change
        self.image = placeholder
        didSetImage(placeholder)

        // Load new image from backend
        guard let url = url else { return }

        Self.session.dataTask(with: url) { (data, _, _) in

            guard let data = data else { return }

            DispatchQueue.main.async {

                guard let image = UIImage(data: data) else { return }
                Self.cache[url] = image
                self.image = image
                didSetImage(image)
            }
        }.resume()
    }
}

// MARK: - Mock support For URLSessions

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
