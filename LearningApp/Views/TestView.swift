//
//  TestView.swift
//  LearningApp
//
//  Created by Elvis Cuevas on 1/16/22.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    var body: some View {
        
       
        if  model.currentQuestion != nil {
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            
                           
                                
                                Button(action: {
                                    // Track the selected index
                                    selectedAnswerIndex = index
                                }, label: {
                                    
                                    ZStack {
                                        
                                        if submitted == false {
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray: .white)
                                                .frame(height: 48)
                                        }
                                        else {
                                            // Answer has been submitted
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.green)
                                                    .frame(height: 48)
                                            }
                                            else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.red)
                                                    .frame(height: 48)
                                            }
                                            else if index == model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.green)
                                                    .frame(height: 48)
                                            }
                                            else {
                                                RectangleCard(color: Color.white)
                                                    .frame(height: 48)
                                            }
                            
                                            
                                        }
                                        Text(model.currentQuestion!.answers[index])
                                    }
                                })
                                .disabled(submitted)
                            
                           
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
                
                // Button
                Button(action: {
                    // Change submitted value to true
                    submitted = true
                    // Check the answer and increment the counter if corerct
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                }, label: {
                    
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text("Submit")
                            .bold()
                            
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    
                })
                .disabled(selectedAnswerIndex == nil)
            }
        
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()
        }
    }
}

