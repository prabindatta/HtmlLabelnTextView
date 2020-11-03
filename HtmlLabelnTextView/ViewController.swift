//
//  ViewController.swift
//  HtmlLabelnTextView
//
//  Created by Prabin Kumar Datta on 03/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mLabel: UILabel! {
        didSet {
            self.mLabel.layer.borderColor = UIColor.green.cgColor
        }
    }
    @IBOutlet weak var mTextView: UITextView!{
        didSet {
            self.mTextView.layer.borderColor = UIColor.yellow.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let htmlString = self.fetchHtml()
//        self.mLabel.attributedText = htmlString.htmlToAttributedString
        self.mLabel.attributedText = htmlString.htmlAttributed(family: "Marker Felt", size: 15, color: .red)
        self.mTextView.attributedText = htmlString.htmlToAttributedString
    }
    
    private func fetchHtml() -> String {
        "<h1>Title</h1><br/><b>Test</b><br/><p>This is a long text for testing with <b>bold words</b></p>"
    }
}

extension UIColor {
    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String(format: "%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
                               lroundf(Float(b * 255)))

        return hexString
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



