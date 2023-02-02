//
//  DataModel.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import Foundation


struct DataModel: Codable{
    var title:String
    var imageName:String
    
    init(title:String, imageName:String){
        self.title = title
        self.imageName = imageName
    }
}
