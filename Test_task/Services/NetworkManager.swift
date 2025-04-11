//
//  NetworkManager.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import Foundation
import Network
import Combine

final class NetworkManager{

    //MARK: Properties
    static let shared = NetworkManager()
    
    let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    @Published var isConnected: Bool = false
    
    //MARK: Initializer
    private init() { startMonitoring() }
    
    //MARK: Methods
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
