//
//  ViewController.swift
//  LnkrTask
//
//  Created by Zaki on 14/10/2022.
//

import UIKit
import CoreNFC

class ViewController: UIViewController , NFCNDEFReaderSessionDelegate {

    @IBOutlet weak var scanNowBttn: UIButton!
    @IBOutlet weak var NFCText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundedBttnWithShadow(Bttn: scanNowBttn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var nfcSession:NFCNDEFReaderSession?
    var word = "None"
    
    @IBAction func scanNowBttn(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self , queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold Your iPhone near an NDEF Card to read messages"
        nfcSession?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("the session was invalidated: \(error.localizedDescription)")
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var result = ""
        for payload in messages[0].records{
            result += String.init(data : payload.payload.advanced(by: 3) , encoding: .utf8) ?? "Formate not supported"
        }
        
        DispatchQueue.main.async {
            self.NFCText.text = result
        }
    }
    
    
    func roundedBttnWithShadow(Bttn: UIButton) {
            Bttn.layer.cornerRadius = Bttn.frame.size.height/2
            Bttn.layer.shadowColor = UIColor.black.cgColor
            Bttn.layer.shadowRadius = 2
            Bttn.layer.shadowOpacity = 0.5
            Bttn.layer.shadowOffset = CGSize(width: 0.0 , height: 2.0)
        }

    
}

