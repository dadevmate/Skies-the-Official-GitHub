//
//  Network.swift
//  Skymie
//
//  Created by Nethan on 21/11/22.
//

import Foundation
import Network


class Network: ObservableObject {
   let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected:Bool = false
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                    self.connected = true
            } else {
                    self.connected = false
            }
        }
        monitor.start(queue: queue)
    }
}
