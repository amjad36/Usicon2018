//
//  Recipe.swift
//  RecipeBook
//
//  Created by Amjad Khan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import Foundation

class Content: BaseModel {
    
    fileprivate enum JsonKey: String {
        case Items        = "Items"
    }
    
    var items: [Item]?
    
    class func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let instance = Content()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        
        let itemsArr = dictionary?[JsonKey.Items.rawValue] as? [Any]
        items = listFromRawArray(itemsArr)
    }
    
    func dictionaryRepresentation() -> [String : Any]? {
        return nil
    }
}

class Item: BaseModel {

    fileprivate enum JsonKey: String {
        case Id                 = "item_id"
        case Title              = "title"
        case ImageName          = "image_name"
        case DestinationUrl     = "destination_url"
    }
    
    var id: String?
    var title: String?
    var imageName: String?
    var destinatonUrl: String?
    
    static func instanceFromDictionary(_ dictionary: [String : Any]?) -> Any? {
        guard dictionary != nil else { return nil }
        
        let item = Item()
        item.setAttributesFromDictionary(dictionary)
        
        return item
    }
    
    func dictionaryRepresentation() -> [String : Any]? {
        
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.Id.rawValue] = id as Any?
        dictionary[JsonKey.Title.rawValue] = title as Any?
        dictionary[JsonKey.ImageName.rawValue] = imageName as Any?
        dictionary[JsonKey.DestinationUrl.rawValue] = destinatonUrl as Any?
        
        if dictionary.isEmpty {
            return nil
        }
        else {
            return dictionary
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        
        guard dictionary?.isEmpty == false else { return }
        
        id = dictionary?[JsonKey.Id.rawValue] as? String ?? String()
        title = dictionary?[JsonKey.Title.rawValue] as? String ?? String()
        imageName = dictionary?[JsonKey.ImageName.rawValue] as? String ?? String()
        destinatonUrl = dictionary?[JsonKey.DestinationUrl.rawValue] as? String ?? String()
    }
}
