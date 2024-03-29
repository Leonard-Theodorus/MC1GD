//
//  NotificationModel.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 04/05/23.
//

import UserNotifications

struct NotificationManager {
    static let instance = NotificationManager()
    
    func setupNotifications(username : String){
        let notifId = "Notif1"
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) {  granted, error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized{
                center.getPendingNotificationRequests { requests in
                    let notificationExists = requests.contains{$0.identifier == notifId}
                    if notificationExists{return}
                    else {
                        let content = UNMutableNotificationContent()
                        content.title = "Isi Pengeluaran Hari ini"
                        content.body = "Hi! \(username) yuk isi pengeluaran hari ini"
                        content.sound = .default
                        var dateComponents = DateComponents()
                        dateComponents.calendar = Calendar.current
                        dateComponents.hour = 19
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                        let request = UNNotificationRequest(identifier: notifId, content: content, trigger: trigger)
                        center.add(request){ (error) in
                            if error != nil{
                                // handle error
                            }
                        }
                    }
                }
            }
            else{
                return
            }
        }
        
    }
}


