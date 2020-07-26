//
//  ViewController.swift
//  HomeControl2
//
//  Created by Przemyslaw Kromólski on 13/01/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit
import Speech


class ViewController: UIViewController,SFSpeechRecognizerDelegate {

    var menuIsHiidden = true
    var isExpanded = false //mic
    let substring1 = "Włącz światło"
    let substring2 = "Wyłącz światło"
    var text:String = ""
    var status = 1
    
    
    //mic
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pl-PL"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
    @IBOutlet var menuView: UIView!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    @IBOutlet var mic1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        leadingConstraint.constant = -190
        
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
        
        mic1.isEnabled = false //mic
        
      
    }

    //panel boczny
    @IBAction func slideBar(_ sender: UIBarButtonItem) {
        if menuIsHiidden {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
        } else {
            leadingConstraint.constant = -190
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
        }
        menuIsHiidden = !menuIsHiidden
    }
    //przycisk mic
    @IBAction func mic1(_ sender: UIButton) {
        if audioEngine.isRunning {
            print("Przerwane przez wduszenie przycisku")
            audioEngine.stop()
            recognitionRequest?.endAudio()
            mic1.isEnabled = false
            mic1.setTitle("Stopping", for: .disabled)
            
            
        } else {
            print("Nagrywanie")
            try! startRecording()
            mic1.setTitle("Stop recording", for: [])
            status = 1 //do sprawdzenia czy wystapilo juz slowo
           
            
            
        }
    }
    
   
    
    //mic
     override public func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
     
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.mic1.isEnabled = true
     
                case .denied:
                    self.mic1.isEnabled = false
                    self.mic1.setTitle("User denied access to speech recognition", for: .disabled)
     
                case .restricted:
                    self.mic1.isEnabled = false
                    self.mic1.setTitle("Speech recognition restricted on this device", for: .disabled)
     
                case .notDetermined:
                    self.mic1.isEnabled = false
                    self.mic1.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
     }
    
   
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    // Przemek: - Handlers
    //mic - Ustawienia rozpoznawania mowy
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record, mode: .default, options: [])
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode //else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
                self.text = result.bestTranscription.formattedString
                self.text = self.text.lowercased() //tylko male litery
            }
            
            if self.status==1
            {
                for slowa in ListWord().slownikSlow.keys {
                    if self.text.contains(slowa)
                    {
                        self.status+=1
                        print(slowa)
                        print("Przerwanie przez znalezienie słowa")
                        self.audioEngine.stop()
                        self.recognitionRequest?.endAudio()
                        self.mic1.isEnabled = false
                        self.mic1.setTitle("Stopping", for: .disabled)
                        if ListWord().slownikSlow[slowa] == 1 {
                           Window1ViewController().activeLed()
                        }
                        if ListWord().slownikSlow[slowa] == 0 {
                            Window1ViewController().inactiveLed()
                        }
                    }
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.mic1.isEnabled = true
                self.mic1.setTitle("Start Recording", for: [])
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        textView.text = "(Słucham...)"
        
    }
    //mic
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            mic1.isEnabled = true
            mic1.setTitle("Start Recording", for: [])
        } else {
            mic1.isEnabled = false
            mic1.setTitle("Recognition not available", for: .disabled)
        }
    }

    
}//koniec klasy


