//
//  RealTimeViewController.swift
//  Hackathon
//
//  Created by Shreeniket Bendre on 8/15/20.
//  Copyright © 2020 Shreeniket Bendre. All rights reserved.
//

import UIKit
import AVKit
import Vision
import AVFoundation

class RealTimeViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    //MARK:-Variable Declerations and IB's
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var camPreview: UIView!
    @IBOutlet var lightSwitch: UISwitch!
    
    
    var captureSession = AVCaptureSession()
    let synth = AVSpeechSynthesizer()
    var oldChar = ""
    var cameraPos = AVCaptureDevice.Position.back
    var captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: AVCaptureDevice.Position.back)
    var def_bright = UIScreen.main.brightness
//    var model: VNCoreMLModel = resnet50().model as! VNCoreMLModel
        
    
    
    //MARK:- Capture Buttons
    @IBAction func stop_captureSession(_ sender: UIButton) {
        captureSession.stopRunning()
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        UIApplication.shared.isIdleTimerDisabled = false
        UIScreen.main.brightness = def_bright
    }
    @IBAction func change_camera(_ sender: Any) {
        captureSession.stopRunning()
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        if cameraPos == AVCaptureDevice.Position.back{
            cameraPos = AVCaptureDevice.Position.front
        }else{
            if UIScreen.main.brightness != def_bright{
                UIScreen.main.brightness = def_bright
            }
            cameraPos = AVCaptureDevice.Position.back
        }
        if lightSwitch.isOn{
            lightSwitch.setOn(false, animated: true)
        }
        captureSession = AVCaptureSession()
        camPreview.layer.sublayers?[0].removeFromSuperlayer()
        oldChar = ""
        self.viewDidLoad()
    }
        @IBAction func change_light(_ sender: UISwitch) {
        if cameraPos == AVCaptureDevice.Position.back{
            try? captureDevice?.lockForConfiguration()
            if sender.isOn{
                try? captureDevice?.setTorchModeOn(level: 1.0)
            }else{
                captureDevice?.torchMode = .off
            }
            captureDevice?.unlockForConfiguration()
        }else{
            if sender.isOn{
                def_bright = UIScreen.main.brightness
                UIScreen.main.brightness = CGFloat(1)
            }else{
                UIScreen.main.brightness = def_bright
            }
        }
    }
    
    //MARK:- View Did's
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCaptureSession()
    
        }
    
    //MARK:- Capture Session
    func setupCaptureSession(){
            
            captureSession.sessionPreset = .photo
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPos)
            
            guard let input = try? AVCaptureDeviceInput.init(device: captureDevice!) else {return}
        
            captureSession.addInput(input)
            captureSession.startRunning()
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            previewLayer.frame = camPreview.bounds
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            camPreview.layer.insertSublayer(previewLayer, at: 0)
        
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoOutputString"))
            captureSession.addOutput(dataOutput)
    }
    
    //MARK:- Capture Output
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            //Setup PixelBuffer
            guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            guard let model = try? VNCoreMLModel(for: resnet50().model) else {
                
                return
            }
            
            //Model Request
            let request = VNCoreMLRequest(model: model) { (finishedRequest, _) in
                guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
                guard let firstObservation = results.first else { return }
                
                DispatchQueue.main.async {

                    if firstObservation.confidence > 0.9 && self.oldChar != String(firstObservation.identifier) {

                        self.objectNameLabel.text = firstObservation.identifier
                        print("NIL\(results)")
                        self.oldChar = self.objectNameLabel.text!
                        let utterance = AVSpeechUtterance(string: String("Warning: \(self.objectNameLabel.text!)" ))
                        self.synth.speak(utterance)
                    }
                    
                }
            }
            request.imageCropAndScaleOption = .centerCrop
            do{
            try VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
            }catch{
        }


}
}
