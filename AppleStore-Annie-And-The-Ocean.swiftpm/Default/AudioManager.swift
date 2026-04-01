//
//  Annie-And-The-Ocean
//
import AVFoundation

class AudioManager {
    static let shared = AudioManager()

    var mainAudio: AVAudioPlayer?
    var storyAudio: AVAudioPlayer?

    private init() {}

    func playMainAudio() {
        guard let filePath = Bundle.main.path(forResource: "main", ofType: "mp4") else { return }
        let audioURL = URL(fileURLWithPath: filePath)
        do {
            mainAudio = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("Cannot Find The Audio")
            return
        }
        mainAudio?.numberOfLoops = -1
        mainAudio?.volume = 0.7
        mainAudio?.play()
    }

    func stopMainAudio() {
        mainAudio?.stop()
    }

    func playStoryAudio() {
        guard let filePath = Bundle.main.path(forResource: "Story", ofType: "mp4") else { return }
        let audioURL = URL(fileURLWithPath: filePath)
        do {
            storyAudio = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("Cannot Find The Audio")
            return
        }
        storyAudio?.numberOfLoops = -1
        storyAudio?.volume = 0.7
        storyAudio?.play(atTime: storyAudio!.deviceCurrentTime + 0.7)
    }

    func stopStoryAudio() {
        storyAudio?.stop()
    }
}
