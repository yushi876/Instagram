//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by YushiT on 2016/09/26.
//  Copyright © 2016年 Yushi. All rights reserved.
//

import UIKit

class ImageSelectViewController: UIViewController {
    @IBAction func handleLibraryButton(sender: AnyObject) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCameraButton(sender: AnyObject) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCancelButton(sender: AnyObject) {
        // 画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if info[UIImagePickerControllerOriginalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // ここでpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            dispatch_async(dispatch_get_main_queue()) {
                
                // AdobeImageEditorを起動する
                let adobeViewController = AdobeUXImageEditorViewController(image: image)
                adobeViewController.delegate = self
                self.presentViewController(adobeViewController, animated: true, completion:  nil)
            }
        }
        
        // 閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // 閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
