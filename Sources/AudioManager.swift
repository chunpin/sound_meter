import Foundation
import AVFoundation

class AudioManager: NSObject, ObservableObject {
    private var audioSession: AVCaptureSession?
    private var audioInput: AVCaptureDeviceInput?
    private var audioOutput: AVCaptureAudioDataOutput?
    private var queue: DispatchQueue
    
    @Published var decibels: Float = 0.0
    @Published var isMonitoring = false
    
    override init() {
        self.queue = DispatchQueue(label: "audio.capture.queue")
        super.init()
        setupAudioCapture()
    }
    
    private func setupAudioCapture() {
        // Find the default audio device
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
            print("No audio device found")
            return
        }
        
        do {
            // Create audio input
            audioInput = try AVCaptureDeviceInput(device: audioDevice)
            
            // Create capture session
            audioSession = AVCaptureSession()
            
            // Create audio output
            audioOutput = AVCaptureAudioDataOutput()
            
            guard let audioSession = audioSession,
                  let audioInput = audioInput,
                  let audioOutput = audioOutput else {
                return
            }
            
            // Configure session
            if audioSession.canAddInput(audioInput) {
                audioSession.addInput(audioInput)
            }
            
            if audioSession.canAddOutput(audioOutput) {
                audioSession.addOutput(audioOutput)
            }
            
            // Set up audio output delegate
            audioOutput.setSampleBufferDelegate(self, queue: queue)
            
        } catch {
            print("Error setting up audio capture: \(error.localizedDescription)")
        }
    }
    
    func startMonitoring() {
        queue.async { [weak self] in
            self?.audioSession?.startRunning()
            DispatchQueue.main.async {
                self?.isMonitoring = true
            }
        }
    }
    
    func stopMonitoring() {
        queue.async { [weak self] in
            self?.audioSession?.stopRunning()
            DispatchQueue.main.async {
                self?.isMonitoring = false
                self?.decibels = 0.0
            }
        }
    }
}

extension AudioManager: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let channelData = AudioManager.processAudioSampleBuffer(sampleBuffer) else {
            return
        }
        
        // Calculate RMS (Root Mean Square) to get audio level
        let rms = AudioManager.calculateRMS(data: channelData)
        
        // Convert to decibels and normalize
        let db = 20 * log10(rms)
        let normalizedDb = max(0, min(100, (db + 50) * 2)) // Normalize to 0-100 range
        
        DispatchQueue.main.async {
            self.decibels = Float(normalizedDb)
        }
    }
    
    private static func processAudioSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> [Float]? {
        guard let audioBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) else {
            return nil
        }
        
        var lengthAtOffset: Int = 0
        var totalLength: Int = 0
        var dataPointer: UnsafeMutablePointer<Int8>?
        
        CMBlockBufferGetDataPointer(audioBuffer,
                                  atOffset: 0,
                                  lengthAtOffsetOut: &lengthAtOffset,
                                  totalLengthOut: &totalLength,
                                  dataPointerOut: &dataPointer)
        
        guard let data = dataPointer else {
            return nil
        }
        
        let samples = UnsafeBufferPointer(start: UnsafeRawPointer(data).assumingMemoryBound(to: Float.self),
                                        count: totalLength / 4)
        return Array(samples)
    }
    
    private static func calculateRMS(data: [Float]) -> Float {
        let squares = data.map { $0 * $0 }
        let meanSquare = squares.reduce(0, +) / Float(data.count)
        return sqrt(meanSquare)
    }
} 