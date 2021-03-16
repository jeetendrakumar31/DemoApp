//
//  NameModelView.swift
//  MantraDemo
//
//  Created by Jeetendra on 16/03/21.
//

import Foundation
import Foundation

class NameModelView: NSObject {
    /**
       @Description :- Get the Category list from  server.
       @Author : Jeetendra
       @Para : nil
       @ Returns: Message Array
       @Date     : 16/03/2021
    */
    func fetchCategoryData() -> [Category] {
        var chatsArray: [Category] = []
       
       if let url = Bundle.main.url(forResource: "menu", withExtension: "json") {
           
           do {
               let data = try Data.init(contentsOf: url)
               let decoder = JSONDecoder.init()
                chatsArray = try decoder.decode([Category].self, from: data)
               print(chatsArray)
              // self.chatCollView.reloadData()
           } catch let err {
               print(err.localizedDescription)
           }
       }
        return chatsArray
 }
}
