import SwiftUI

@main
struct SoundMeterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 400)
                .background(Color(NSColor.windowBackgroundColor))
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the app name in the menu bar
        NSApp.setActivationPolicy(.regular)
        
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
        
        // Bring app to front
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}