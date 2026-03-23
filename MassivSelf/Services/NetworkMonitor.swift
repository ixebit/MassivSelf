// NetworkMonitor.swift
// Monitors network connectivity using NWPathMonitor
// Used to show offline banner — app works fully offline

import Network
import Observation
import Foundation

@Observable
final class NetworkMonitor {

    // MARK: - Properties

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.massivself.networkmonitor")

    var isConnected: Bool = true
    var isExpensive: Bool = false

    // MARK: - Init / Deinit

    init() {
        startMonitoring()
    }

    deinit {
        stopMonitoring()
    }

    // MARK: - Monitoring

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.isExpensive = path.isExpensive
            }
        }
        monitor.start(queue: queue)
    }

    private func stopMonitoring() {
        monitor.cancel()
    }
}
