//
//  cameraViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/13/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit
import AVFoundation


class cameraViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var previewView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
        } catch{
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session:captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        previewView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()*/
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        //imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
   /* override func viewWillAppear(_ animated: Bool) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    */
    //https://stackoverflow.com/questions/51504442/infokey-is-not-a-member-type-of-uiimagepickercontroller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInto info: [String : Any]){
       
        let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        imagePicker.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
