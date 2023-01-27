//
//  ImageUploadClass.swift
//  DJConnect
//
//  Created by Techugo on 19/07/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import Photos

@objc protocol FileUploaderDelegate {
    @objc optional func uploadStarted()
    @objc optional func uploadUpdated(_ progress : NSNumber)
    @objc optional func uploadEnded()
    @objc optional func showError(_ message: String, title: String?)
    @objc optional func uploadFailed()
}

class FileUploader: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    weak var delegate: AnyObject?
    var applicationId: String?
    var uploadURL: URL?
    var inputFilename: String?
    var ticketTask: URLSessionDataTask?
    var uploadTask: URLSessionUploadTask?
    var filesize: Int64?
    var responseStatus: Int?

    init(_delegate: AnyObject) {
        delegate = _delegate
        uploadURL = nil
        inputFilename = nil
    }

    private func dispatchError(_ errorMessage: String) {
        DispatchQueue.main.async(execute: {
            debugPrint("FileUploader error: \(errorMessage)")
            self.delegate?.showError?(errorMessage, title: nil)
        })
    }

    func getTicketAndUploadFromPicker(info: [UIImagePickerController.InfoKey: Any], title: String? = nil, author: String? = nil, customData: String? = nil) {
        guard let filePath = (info[UIImagePickerController.InfoKey.mediaURL] as? URL)?.path else {
            return self.dispatchError("Media not found")
        }

        // Ticket request payload
        var params:[String:String] = [String:String]()

        // Custom metadata
        if (title != nil) {
            params["title"] = title
        }
        if (author != nil) {
            params["author"] = author
        }
        if (customData != nil) {
            params["custom_data"] = customData
        }

        // Media metadata
        params["type"] = info[UIImagePickerController.InfoKey.mediaType] as! String == "public.image" ? "image" : "video"
        params["filename"] = params["type"]! + "." + (params["type"] == "image" ? ".jpg" : ".mp4")
        let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset
        if (asset != nil) {
            let date = asset?.creationDate?.timeIntervalSince1970
            if (date != nil) {
                params["created"] = String(Int(date!))
            }
        }

        // Client metadata
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)
        let hardware: String = String(cString: hw_machine)
        params["device_model"] = hardware
        params["platform"] = "iOS"
        params["platform_version"] = UIDevice.current.systemVersion
        params["manufacturer"] = "Apple"

        let postData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        let request = NSMutableURLRequest()
        request.url = URL(string: "https://cdn.bambuser.net/uploadTickets")
        request.httpMethod = "POST"
        request.timeoutInterval = 10.0
        request.setValue(postData?.count.description, forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.bambuser.cdn.v1+json", forHTTPHeaderField: "Accept")
        request.setValue(applicationId, forHTTPHeaderField: "X-Bambuser-ApplicationId")
        request.setValue(Bundle.main.bundleIdentifier! + " " + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String), forHTTPHeaderField: "X-Bambuser-ClientVersion")
        request.setValue("iOS " + UIDevice.current.systemVersion, forHTTPHeaderField: "X-Bambuser-ClientPlatform")
        request.httpBody = postData

        ticketTask = Foundation.URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard error == nil else { return self.dispatchError(error!.localizedDescription) }
            do {
                try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            } catch {
                return self.dispatchError(NSString(data: data!, encoding:String.Encoding.utf8.rawValue)! as String)
            }
            let parsedData = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())) as! NSDictionary
            guard parsedData["error"] == nil else {
                let responseError = parsedData["error"] as! NSDictionary
                print(responseError)
                return self.dispatchError(responseError["message"]! as! String)
            }
            self.uploadURL = URL(string: (parsedData["upload_url"] as? String)!)
            guard self.uploadURL != nil else {
                return self.dispatchError("Unexpected response from upload server, please try again.")
            }
            DispatchQueue.main.async(execute: {
                self.uploadFile(filePath)
            })
        })
        ticketTask?.resume()
    }

    func uploadFile(_ filename: String) {
        inputFilename = filename
        let request = NSMutableURLRequest()
        request.url = uploadURL!
        request.httpMethod = "PUT"
        var attr = (try? FileManager.default.attributesOfItem(atPath: inputFilename!)) as [FileAttributeKey : AnyObject]?
        filesize = attr?[FileAttributeKey.size]?.int64Value
        responseStatus = 0

        request.addValue(filesize!.description, forHTTPHeaderField: "Content-Length")

        let inputStream = InputStream(fileAtPath: inputFilename!)

        request.httpBodyStream = inputStream
        request.timeoutInterval = 60.0

        let sessionConfig:URLSessionConfiguration = URLSessionConfiguration.default
        let queue = OperationQueue()
        let session:Foundation.URLSession = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: queue)
        uploadTask = session.uploadTask(withStreamedRequest: request as URLRequest)
        uploadTask?.resume()
        DispatchQueue.main.async(execute: {
            self.delegate?.uploadStarted?()
        })
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        let inputStream = InputStream(fileAtPath: inputFilename!)
        completionHandler(inputStream)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Float(totalBytesSent) / Float(filesize!)
        DispatchQueue.main.async(execute: {
            self.delegate?.uploadUpdated?(NSNumber(value: progress))
        })
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async(execute: {
            if (error != nil) {
                if (error!._code != NSURLErrorCancelled) {
                    self.delegate?.uploadFailed?()
                }
            } else {
                if (self.responseStatus! == 200) {
                    self.delegate?.uploadEnded?()
                } else {
                    self.delegate?.uploadFailed?()
                }
            }
        })
        self.cancelAndFinalizeUploadTask()
    }

    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if (error != nil) {
            DispatchQueue.main.async(execute: {
                self.delegate?.uploadFailed?()
            })
        }
        self.cancelAndFinalizeUploadTask()
    }

    func urlSession(_ session: Foundation.URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {

        if let httpResponse = response as? HTTPURLResponse {
            responseStatus = httpResponse.statusCode

            if (responseStatus == 200) {
            } else if (responseStatus! >= 400 && responseStatus! < 500) {
                // Client error
                print("Upload was not accepted");
            } else if (responseStatus! >= 500 && responseStatus! < 600) {
                // Server error
                print("Upload was not accepted");
            } else {
                print("Unexpected status code:", responseStatus!);
            }
        }
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }

    func cancelUpload() {
        self.cancelAndFinalizeUploadTask()
    }

    fileprivate func cancelAndFinalizeUploadTask() {
        ticketTask?.cancel()
        uploadTask?.cancel()
        ticketTask = nil
        uploadTask = nil
    }
}
