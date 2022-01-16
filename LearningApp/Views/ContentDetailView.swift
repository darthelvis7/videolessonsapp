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
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack {
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
            // Description
            CodeTextView()
            
            if model.hasNewLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
            else {
                // Show complete button instead
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
          
        }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}


