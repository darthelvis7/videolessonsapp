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
    
    // Current lressdon
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    
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
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
        
        
    }
    
    
    
    
    
}
