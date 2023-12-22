//
//  YTView.swift
//  YT
//
//  Created by Jeremy Christopher on 04/05/23.
//

import SwiftUI
import WebKit

struct YTView: View {
    let ID: String
    var body: some View {
        Video(videoID: ID)
            .frame(width: 350, height: 190)
            .cornerRadius(12)
            .padding(.horizontal, 24)
    }
}

struct YTView_Previews: PreviewProvider {
    static var previews: some View {
        YTView(ID: "62FZ-992ARU")
    }
}

struct Video: UIViewRepresentable{
    let videoID: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let YoutubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")else
        {return}
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: YoutubeURL))
        
        
    }
}
