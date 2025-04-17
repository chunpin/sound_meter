import SwiftUI

@main
struct SoundMeterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(audioManager: audioManager)
                .frame(minWidth: 300, minHeight: 400)
                .background(Color(NSColor.windowBackgroundColor))
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .commands {
            CommandGroup(replacing: .newItem) { }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the main menu
        let mainMenu = NSMenu()
        NSApp.mainMenu = mainMenu
        
        // App menu
        let appMenuItem = NSMenuItem()
        appMenuItem.submenu = NSMenu()
        mainMenu.addItem(appMenuItem)
        
        // App menu items
        let appMenu = appMenuItem.submenu!
        appMenu.addItem(NSMenuItem(title: "About Sound Meter",
                                 action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)),
                                 keyEquivalent: ""))
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(NSMenuItem(title: "Quit",
                                 action: #selector(NSApplication.terminate(_:)),
                                 keyEquivalent: "q"))
        
        // Set up notification center
        NSUserNotificationCenter.default.delegate = self
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false // Don't quit when window is closed
    }
    
    // MARK: - NSUserNotificationCenterDelegate
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                              shouldPresent notification: NSUserNotification) -> Bool {
        return true // Always show notifications
    }
}