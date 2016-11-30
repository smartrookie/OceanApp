//
//  QRCaptureViewController.swift
//  OceanApp
//
//  Created by rookie on 2016/11/29.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import AVFoundation

class QRCaptureViewController: UIViewController {
    
    let device      = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    let scanSession = AVCaptureSession()
    
    lazy var failureLabel : UILabel = { [unowned self] in
        $0.frame = self.view.bounds
        $0.numberOfLines = 0
        $0.textColor = UIColor.oc_lightGrayColor()
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "QRCapture"
        view.backgroundColor = UIColor.oc_whiteColor()
        
        let authorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authorizationStatus {
        case .authorized:
            break
        case .denied,.notDetermined,.restricted:
            launchScanFailure(authorizationStatus)
            return
        }
        
        var input : AVCaptureDeviceInput?
        do {
           input = try AVCaptureDeviceInput(device: device)
        } catch {
            print("input initial error ")
        }
        let output = AVCaptureMetadataOutput()
        
        guard scanSession.canAddInput(input) else {
            print("scanSession add Input Error")
            return
        }
        guard scanSession.canAddOutput(output) else {
            print("scanSession add output Error")
            return
        }
        
        scanSession.addInput(input)
        scanSession.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        output.rectOfInterest = view.bounds
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: scanSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
        
        scanSession.startRunning()
        
    }
    
    func launchScanFailure(_ status: AVAuthorizationStatus) {
        
        var err = ""
        switch status{
        case .authorized:
            break
        case .denied:
            err = "denied"
            break
        case .notDetermined:
            err = "notDetermined"
            break
        case .restricted:
            err = "restricted"
            break
        }
        print("AV author err = \(err)")
        
        failureLabel.text = err
        view.addSubview(failureLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleQRResult(_ result: String) {
        
        let alert = UIAlertController(title: nil, message: result, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open in Safari", style: .default, handler: { (_) in
            UIApplication.shared.openURL(URL(string: result)!)
            self.scanSession.startRunning()
        }))
        
        alert.addAction(UIAlertAction(title: "复制", style: .default, handler: { (_) in
            UIPasteboard.general.string = result
            self.scanSession.startRunning()
        }))
        
        alert.addAction(UIAlertAction(title: "分享", style: .default, handler: { (_) in
            self.shareQRResult(result)
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            self.scanSession.startRunning()
        }))
        
        present(alert, animated: true ,completion: nil)
    }
    
    func shareQRResult(_ result: String) {
        
        let activityController = UIActivityViewController(activityItems: [QRActivityItem(URL(string: result), nil)], applicationActivities: nil)
        activityController.excludedActivityTypes = [.postToTwitter,
                                                    .postToFacebook,
                                                    .postToVimeo,
                                                    .postToTencentWeibo,
                                                    .print,
                                                    .assignToContact,
                                                    .saveToCameraRoll,
                                                    .postToFlickr,
                                                    .airDrop,
                                                    .message,]
        present(activityController, animated: true, completion: nil)
        
        
        activityController.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) in
            self.scanSession.startRunning()
        }
    }
    
}


extension QRCaptureViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            if scanSession.isRunning {
                scanSession.stopRunning()
            }
            let qr_result = (metadataObjects.last as! AVMetadataMachineReadableCodeObject).stringValue
            handleQRResult(qr_result!)
        }
    }
}


















