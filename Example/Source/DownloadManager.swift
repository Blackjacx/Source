//
//  DownloadManager.swift
//  Source_Example
//
//  Created by Stefan Herold on 21.02.20.
//  Copyright © 2021 Stefan Herold. All rights reserved.
//

import UIKit

public final class DownloadManager {

    public enum DownloadError: Error {
        case imageSerializationFailed
    }

    public typealias RequestResult = Result<(image: UIImage, fromCache: Bool), DownloadError>
    public typealias FetchCompletion = (_ result: RequestResult) -> Void
    public typealias BatchCompletion = (_ results: [RequestResult]) -> Void

    public static let shared = DownloadManager()

    private var cache: [URL: UIImage] = [:]
    private var tasks: [URL: URLSessionTask] = [:]
    private let session: URLSessionProtocol = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        return URLSession(configuration: config)
    }()

    /// Serial dispatch queue to provide serialized access to the cache.
    private let serialQueue = DispatchQueue(label: "com.stherold.download_maganer")

    private init() {}

    /// Fetches data from multiple urls and returns the result as an array.
    public func fetch(_ urls: [URL],
                      session: URLSessionProtocol? = nil,
                      completion: @escaping BatchCompletion) {

        var results: [RequestResult] = []

        urls.forEach {
            DownloadManager.shared.fetch($0) { [weak self] (result) in
                self?.serialQueue.async {
                    results.append(result)
                    if results.count == urls.count {
                        DispatchQueue.main.async {
                            completion(results)
                        }
                    }
                }
            }
        }
    }

    /// Fetches the data from the provided url and calls the completion
    /// handler with the result.
    /// - parameters:
    ///   - url: The url to load the image from
    ///   - session: A URLSession object that is used to perform the task. This
    ///   is used in unit tests to replace the network request by a mocked one.
    ///   If not specified a default session is used that performs a real
    ///   network request.
    ///   - completion: The completion handler called when an image has been
    ///   successfully loaded.
    public func fetch(_ url: URL,
                      session: URLSessionProtocol? = nil,
                      completion: @escaping FetchCompletion) {

        // I have to store this object here since non static properties are not
        // permitted as default values.
        let session: URLSessionProtocol = session ?? self.session

        serialQueue.async { [weak self] in

            // Check cache first
            if let cachedImage = self?.cache[url] {
                DispatchQueue.main.async {
                    completion(.success((cachedImage, true)))
                }
                return
            }

            let task = session.dataTask(with: url) { (data, response, error) in

                defer {
                    // Release the tasks reference when exitting this function
                    self?.tasks[url] = nil
                }

                guard let data = data, let image = UIImage(data: data, scale: UIScreen.main.scale) else {
                    DispatchQueue.main.async {
                        completion(.failure(.imageSerializationFailed))
                    }
                    return
                }

                self?.serialQueue.async {
                    self?.cache[url] = image
                }

                DispatchQueue.main.async {
                    completion(.success((image, false)))
                }
            }
            // Keep a reference to this task
            self?.tasks[url] = task
            task.resume()
        }
    }
}

// MARK: - Mock support For URLSessions

public typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
