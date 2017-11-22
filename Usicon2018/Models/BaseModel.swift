//
//  BaseModel.swift
//

import Foundation

// MARK: - Model Protocol

protocol BaseModel {
    
    static func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any?
    static func instanceFromData(_ data: Data) -> Any?
    static func instanceFromFile(_ fileName: String) -> Any?
    
    func dictionaryRepresentation() -> [String: Any]?
    func setAttributesFromDictionary(_ dictionary: [String: Any]?)
}

// MARK: - BaseModel extension

extension BaseModel {
    
    static func instanceFromData(_ data: Data) -> Any? {
        
        if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                return instanceFromDictionary(jsonDict! as [String: Any])
        }
        return nil
    }
    
    static func instanceFromFile(_ fileName: String) -> Any? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if let _ = path {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
                return instanceFromData(data)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func listFromRawArray<T: BaseModel>(_ listArray:[Any]?) -> [T]? {
        if listArray == nil {
            return nil
        }
        
        var itemList = [T]()
        for (element) in listArray! {
            let instance = T.instanceFromDictionary(element as? [String : Any]) as? T
            
            if instance != nil {
                itemList.append(instance!)
            }
        }
        
        return itemList
    }
}
