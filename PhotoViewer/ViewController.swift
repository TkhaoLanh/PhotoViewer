//
//  ViewController.swift
//  PhotoViewer
//
//  Created by user248619 on 10/10/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var myImgView: UIImageView!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    let imageModel = Image()
    var imageNames : [String] = []
    var indexId = 0
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexId = row
        updateImg()
    }
    
    func updateImg(){
        let photoName = Array(imageModel.listOfImages.keys)[indexId]
        let photoURL = Array(imageModel.listOfImages.values)[indexId]
        
        Service.shared.getImage(urlStr: photoURL) { imageData in
            if let imageData = imageData {
                DispatchQueue.main.async {
                    self.myImgView.image = UIImage(data: imageData)
                }
            } else {
                // Handle error here, e.g., print a message or display a placeholder image
                print("Error: Unable to fetch image data")
            }
        }
    }
    
    

    
    @objc func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            if indexId == 0 {
                indexId = imageModel.listOfImages.count - 1
            } else {
                indexId -= 1
            }
        default:
            break
        }
        myPickerView.selectRow(indexId, inComponent: 0, animated: true)
        updateImg()
    }
        
    @objc func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
            switch sender.direction {
            case .left:
                indexId += 1
                if indexId >=  imageModel.listOfImages.count{
                    indexId = 0
                }
                
            default:
                break
            }
            myPickerView.selectRow(indexId, inComponent: 0, animated: true)
            updateImg()
            
            
        }
    
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                // Populate the imageNames array from the model
                imageNames = Array(imageModel.listOfImages.keys)
                
                let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
                rightSwipeGesture.direction = .right
                myImgView.addGestureRecognizer(rightSwipeGesture)
                
                
                 let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
                leftSwipeGesture.direction = .left
                myImgView.addGestureRecognizer(leftSwipeGesture)
                
                myImgView.isUserInteractionEnabled = true
                updateImg()
            }
            
            
        }
    



