//
//  ContentViewModel.swift
//  Offline Alerter
//
//  Created by David Reese on 4/1/21.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var connectionState: ConnectionState? = nil
    
    init() {
        update()
        Timer.scheduledTimer(timeInterval: 23, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        let oldState = connectionState ?? .connected
        let isConnected = Reachability().isConnectedToNetwork()
        if isConnected {
            let request = URLRequest(url: URL(string: "https://www.google.com")!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 18)
            
//            let request = NSMutableURLRequest(url: URL(string: "https://kolhatorahkulah.com/content/videos.txt")!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
//            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _ = data else {
                    print(error)
                    DispatchQueue.main.async {
                        self.connectionState = .connectedWithoutService
                        if oldState != self.connectionState {
                            sendNotification(title: "Connection Status", subtitle: "You are \(self.connectionState!.rawValue).")
                        }
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.connectionState = .connected
                    if oldState != self.connectionState {
                        sendNotification(title: "Connection Status", subtitle: "You are \(self.connectionState!.rawValue).")
                    }
                }
            }
            
            task.resume()
        } else {
            self.connectionState = .disconnected
            if oldState != self.connectionState {
                sendNotification(title: "Connection Status", subtitle: "You are \(self.connectionState!.rawValue).")
            }
        }
    }
}

func sendNotification(title: String, subtitle: String = "Click to see moe information.") -> Void {
    let notification = NSUserNotification()
    notification.title = title
    notification.subtitle = subtitle
    notification.soundName = NSUserNotificationDefaultSoundName
    NSUserNotificationCenter.default.deliver(notification)
}
