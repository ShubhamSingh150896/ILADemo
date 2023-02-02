//
//  ViewModel.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import Foundation


class ViewModel: NSObject {
    private var contentList = [DataModel]()
    private var filteredList = [DataModel]()
    var searchActive: Bool = false
    
    //MARK:- Filter
    func searchList(searchText: String) {
        if searchText == "" {
            self.searchActive = false
            filteredList = self.contentList
        } else {
            self.searchActive = true
            filteredList = self.contentList.filter({(($0.title.localizedCaseInsensitiveContains(searchText)))})
        }
    }
    
    //MARK:- Get list count
    func getListCount() -> Int {
        return filteredList.count
    }
    
    //MARK:- Get Index Model and Data
    func getIndexModel(index: Int) -> DataModel? {
        return filteredList[index]
    }
    
    
    func getCarouselListCount() -> Int {
        return contentList.count
    }
    
    //MARK:- Get Index Model and Data
    func getCarouselIndexModel(index: Int) -> DataModel? {
        return contentList[index]
    }
    
    //MARK:- Get Local DataList using Json file.
    public func getLocalDataList(completion: @escaping (_ reload: Bool) -> Void) {
        do {
            if let bundlePath = Bundle.main.url(forResource: "Content", withExtension: "json") {
               let data = try Data(contentsOf: bundlePath, options: [])
               let homeData = try JSONDecoder().decode([DataModel].self,from: data)
               contentList = homeData
               filteredList = homeData
               completion(true)
            }
        } catch {
            completion(false)
            print(error)
        }
    }
    
    //MARK:- Refresh Data list
    func refreshData()  {
        filteredList = contentList.shuffled()
    }
    
    //MARK:- Return Complete List
    func getCarouselList() -> [DataModel]? {
        return contentList
    }
    
}
