//
//  ContentModel.swift
//  LearningApp
//
//  Created by Elvis Cuevas on 11/28/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
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
            print("erro")
        }
        
        
    }
    
    
}
