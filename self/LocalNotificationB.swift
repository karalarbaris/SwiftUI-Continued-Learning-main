//
//  LocalNotificationB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 12.07.23.
//

import SwiftUI
import UserNotifications

class NotificationManagerB {
    
    static let instance = NotificationManagerB()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is first notification"
        content.subtitle = "Content subtitle"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 53
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // location
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        
        
        
    }
}

struct LocalNotificationB: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationB_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationB()
    }
}
