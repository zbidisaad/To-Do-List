//
//  Item.swift
//  test
//
//  Created by Saad Zbidi on 28/11/2021.
//

import Foundation

class Item: NSObject, NSCoding {

    var name: String

    init(name: String){

        self.name = name

        super.init()

    }

    required convenience init?(coder aDecoder: NSCoder) {

        let name = aDecoder.decodeObject(forKey: "name") as! String

        self.init(name: name)

    }

    func encode(with coder: NSCoder) {

        coder.encode(name, forKey: "name")

    }

    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    static let ArchiveURL = Dir.appendingPathComponent("items")
}
