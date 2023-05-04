//
//  NotificationModel.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 04/05/23.
//

import Foundation
import UserNotifications
struct notificationModel {
    static let instance = notificationModel()
    func setupNotifications(username : String){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) {  granted, error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized{
                let content = UNMutableNotificationContent()
                content.title = "Isi Pengeluaran Hari ini"
                content.body = "Hi! \(username) yuk isi pengeluaran hari ini"
                content.sound = .default
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = 19
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let notifId = UUID().uuidString
                let request = UNNotificationRequest(identifier: notifId, content: content, trigger: trigger)
                center.add(request){ (error) in
                    if error != nil{
                        // handle error
                    }
                }
            }
            else{
                return
            }
        }
        
    }
    
//    func setupNotifications1(username : String){
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) {  granted, error in
//            if let error = error{
//                print(error.localizedDescription)
//            }
//        }
//        center.getNotificationSettings { settings in
//            if (settings.authorizationStatus == .authorized){
//                let content = UNMutableNotificationContent()
//                content.title = "Isi Pengeluaran Hari ini"
//                content.body = "Hi! \(username) yuk isi pengeluaran hari ini"
//                content.sound = .default
//                
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//                let notifId = UUID().uuidString
//                let request = UNNotificationRequest(identifier: notifId, content: content, trigger: trigger)
//                center.add(request){ (error) in
//                    if error != nil{
//                        // handle error
//                    }
//                }
//            }
//            else{
//                return
//            }
//        }
//       
//        
//        
//    }
}


