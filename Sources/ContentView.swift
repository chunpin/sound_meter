import SwiftUI

struct ContentView: View {
    @ObservedObject var audioManager: AudioManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sound Meter")
                .font(.title)
                .padding()
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0, to: CGFloat(min(audioManager.decibels / 100, 1.0)))
                    .stroke(
                        audioManager.decibels < 60 ? Color.green :
                            audioManager.decibels < 80 ? Color.yellow : Color.red,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.2), value: audioManager.decibels)
                
                VStack {
                    Text("\(Int(audioManager.decibels))")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                    Text("dB")
                        .font(.headline)
                }
            }
            
            VStack(spacing: 10) {
                Text("Alert Threshold: \(Int(audioManager.threshold)) dB")
                    .font(.headline)
                
                Slider(value: $audioManager.threshold, in: 0...100, step: 1)
                    .padding(.horizontal)
            }
            
            Button(action: {
                if audioManager.isMonitoring {
                    audioManager.stopMonitoring()
                } else {
                    audioManager.startMonitoring()
                }
            }) {
                Text(audioManager.isMonitoring ? "Stop Monitoring" : "Start Monitoring")
                    .padding()
                    .background(audioManager.isMonitoring ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(width: 300, height: 400)
        .padding()
        .background(Color(NSColor.windowBackgroundColor))
        .onAppear {
            NSWindow.allowsAutomaticWindowTabbing = false
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioManager: AudioManager())
    }
}
#endif 