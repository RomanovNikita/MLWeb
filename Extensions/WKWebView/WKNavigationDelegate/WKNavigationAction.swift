import WebKit

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if let url = webView.url {
            self.addressBar.text = url.absoluteString
        }
        
        let displayLink = CADisplayLink(
                target: self,
                selector: #selector(self.snapshoter))
        
        displayLink.preferredFramesPerSecond = 3
        displayLink.add(to: .current, forMode: .common)
    }
    @objc fileprivate func snapshoter() {
        self.webView.takeSnapshot(with: nil) { image, error in
            guard let image = image, error == nil else { return }
            //print("Snapshot -- \(Date())")
            
            self.viewRect.inputImage(image: image)
        }
    }
}
