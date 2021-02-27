//
//  AppDelegate.swift
//  Plantify
//
//  Created by Ali Lavaee on 8/1/20.
//  Copyright © 2020 Swift Creator. All rights reserved.
//
import UIKit
import SafariServices
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif


class PredictionViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // MARK: IBOutlets...................
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var rounded: UIView!
    @IBOutlet weak var learnmorebtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        learnmorebtn.isHidden = true
        backbtn.isHidden = false
        self.resultsView.layer.cornerRadius = 20
        self.rounded.layer.cornerRadius = 20
        self.learnmorebtn.layer.cornerRadius = 20
        self.backbtn.layer.cornerRadius = 20
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        resultsLabel.text = "Use or take an image of a single leaf of a plant."
        
    }

    // MARK: IBActions...................
    @IBAction func takeImageWithCamera(_ sender: Any) {
        presentPicker(with: .camera)
    }

    @IBAction func pickImageFromLibrary(_ sender: Any) {
        presentPicker(with: .photoLibrary)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let image = info[.originalImage] as! UIImage
    
        imageView.image = image
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 224, height:224))
        let resized_image = renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: CGSize(width: 224, height:224)))
        }
        
        let imageData = resized_image.jpegData(compressionQuality: 1)
        let imageBase64String = imageData!.base64EncodedString()
        
        
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = [
          [
            "key": "file",
            "src": imageBase64String, //change this
            "type": "file"
          ],
          [
            "key": "plant_type",
            "value": Plant,
            "type": "text"
          ]] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = "test.jpg"
              body += "; filename=\(paramSrc)\"\r\n"
                + "Content-Type: \"text-plain\"\r\n\r\n\(imageBase64String)\r\n"
            }
          }
        }

        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://ec2-3-137-153-150.us-east-2.compute.amazonaws.com:5000/classify")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.resultsLabel.text = "\(res.diagnosis)"
                        self.showResults()
                    }

                        
                } catch let error {
                    print(String(describing: error))
                    semaphore.signal()
                    return
                }
          }
            
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
    
    struct Response: Codable {
        var diagnosis: String
    }
    
    func presentPicker(with sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    
        hideResultsView()
    }


    func hideResultsView() {
        self.resultsView.alpha = 0
    }

    func showResultsView() {
        self.resultsView.alpha = 1
        learnmorebtn.isHidden = false
    }
    
    func minResultsView() {
        self.resultsView.alpha = 1
        learnmorebtn.isHidden = true
    }
    
    func showResults() {
        
        if (self.resultsLabel.text!.contains("Healthy")) {
            self.minResultsView()
        }
        
        else {
            self.showResultsView()
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let query = self.resultsLabel.text!
        let replaced = query.replacingOccurrences(of: "\\s", with: "+", options: .regularExpression)
        let vc = SFSafariViewController(url: URL(string: "https://www.google.com/search?q=" + replaced + "%20" + "treatment" )!)
        present(vc, animated: true)
        
    }
    
    
    @IBAction func backbtnTapped(_ sender: Any) {
        viewDidLoad()
        backbtn.isHidden = true
        learnmorebtn.isHidden = true
        
        let vc = storyboard?.instantiateViewController(identifier:"plant_menu_vc") as! PlantMenuController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)

    }

    
}



