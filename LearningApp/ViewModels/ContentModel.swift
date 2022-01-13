//
//  ContentModel.swift
//  LearningApp
//
//  Created by Elvis Cuevas on 11/28/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // Mark: - Data Methods
    
    func getLocalData() {
        // get a url to the json file
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        // Read the file into a data object
        
        do {
        let jsonData = try Data(contentsOf: jsonURL!)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            self.modules = modules
            
    
        }
        catch {
            print(error)
        }
        
        
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
           let styleData = try Data(contentsOf: styleURL!)
            self.styleData = styleData
            
        }
        catch {
            print("error")
        }
        
        
    }
    
    // Mark: - Module Control Methods
    
    func beginModule(_ moduleid: Int) {
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
            
        }
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        // check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
            
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
        
        
    }
    
    func nextLesson() {
        // advance the lesson index
        currentLessonIndex += 1
        // check that its whithin range
        if currentLessonIndex < currentModule!.content.lessons.count {
        // set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNewLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count) 
          
       
    }
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        //Add the styling data
        if styleData != nil {
        data.append(self.styleData!)
        }
        // Add the html data
        data.append(Data(htmlString.utf8))
        // Convert to attributed string
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString   
        }
        return resultString
    }
    
    
    
    
    
    
}
