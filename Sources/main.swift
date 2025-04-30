import SwiftUI
import UserNotifications

@main
struct TimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 300, height: 200)
        }
        .windowResizability(.contentSize)
    }
}

struct ContentView: View {
    @State private var minutes: Int = 10
    @State private var isTimerRunning = false
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Simple Timer")
                .font(.title)
            
            if isTimerRunning {
                Text(timeString(from: remainingSeconds))
                    .font(.system(size: 40, weight: .bold))
                
                Button("Cancel") {
                    stopTimer()
                }
                .buttonStyle(.bordered)
            } else {
                HStack {
                    Text("Minutes: ")
                    TextField("", value: $minutes, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 60)
                }
                
                Button("Start Timer") {
                    startTimer()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        remainingSeconds = minutes * 60
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                stopTimer()
                sendNotification()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Timer"
        content.body = "Time is up!"
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
        
        // Also use the say command
        let task = Process()
        task.launchPath = "/usr/bin/say"
        task.arguments = ["Timer done"]
        try? task.run()
    }
}
