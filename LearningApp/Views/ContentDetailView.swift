//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Elvis Cuevas on 12/29/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        
        let lesson = model.currentLesson
        let url = 
        VideoPlayer(player: AVPlayer(url: <#T##URL#>))
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
