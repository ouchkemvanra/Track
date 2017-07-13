//
//  CameraViewController.swift
//  Track
//
//  Created by ty on on 6/13/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import ImagePicker

class CameraViewController: UIViewController, ImagePickerDelegate {
    var imagess: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showCamera() {
        
    }
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("Hello")
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("zzz")
        
        let totalImages = images
        self.imagess.append(contentsOf: totalImages)
        self.dismiss(animated: true, completion: nil)
        
       
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        print("dfdsfsf")
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
