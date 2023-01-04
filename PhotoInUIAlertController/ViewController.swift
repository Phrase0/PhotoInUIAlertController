//
//  ViewController.swift
//  PhotoInUIAlertController
//
//  Created by Peiyun on 2023/1/4.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func myAlert(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Air Drop", message: "Kitty wants to share this photo", preferredStyle: .alert)


        
        //加入圖片
        guard let image = UIImage(named: "myCat") else { return }
        
        
        //設定最大尺寸
        let maxSize = CGSize(width: 245, height: 300)
        //設定圖片尺寸
        let imgSize = image.size
        //設定比例
        var ratio:CGFloat
        //直向
        if imgSize.height > imgSize.width{
            ratio = maxSize.height / imgSize.height
        }else{
            //橫向或正方形
            ratio = maxSize.width / imgSize.width
        }
        //縮放比例
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        let scaledImg = resizeImage(image: image, targetSize: scaledSize)

        
        //加入圖片：圖片也是警告控制起裡的一個選項
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        
        //讓圖片是不能點選的
        imgAction.isEnabled = false
        //產生一個選項
        //withRenderingMode(.alwaysOriginal):讓圖片能正式顯示
        imgAction.setValue(scaledImg!.withRenderingMode(.alwaysOriginal), forKey: "image")
        alert.addAction(imgAction)
        
        
        let decline = UIAlertAction(title: "Decline", style: .cancel, handler: nil)
        let accept = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alert.addAction(decline)
        alert.addAction(accept)
        present(alert, animated: true)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //使圖片可縮放的方法
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

