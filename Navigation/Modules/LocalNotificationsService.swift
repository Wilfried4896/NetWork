
import UserNotifications
import UIKit


class LocalNotificationsService: UIViewController {
    
    private let center = UNUserNotificationCenter.current()
    
    func registerForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { success, error in
            if success {
                self.createNotification()
            } else {
                print("Notifications permission denied because \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    
    private func createNotification() {
        center.getNotificationSettings {[weak self] setting in
            guard setting.authorizationStatus == .authorized else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "content_title".localized
            content.sound = UNNotificationSound.defaultCritical
            content.body = "content_body".localized
            
            DispatchQueue.main.async {
                content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
            }
            content.categoryIdentifier = "updates"

            var dateComponent = DateComponents()
            dateComponent.hour = 15
            dateComponent.minute = 20
    

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            self?.center.delegate = self
            self?.center.add(request)
        }
    }
    
    func registerUpdatesCategory() {
        let readedAction = UNNotificationAction(identifier: "actionRead", title: "Readed", options: [.foreground])

        let deletedAction = UNNotificationAction(identifier: "deletedAction", title: "Deleted", options: [.destructive])

        let category = UNNotificationCategory(identifier: "updates", actions: [readedAction, deletedAction], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
  
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            switch response.actionIdentifier {
            case "actionRead":
                print("actionRead")
            case "deletedAction":
                print("deletedAction")
            default:
                print("Default")
            }
        }
        completionHandler()
    }
}

