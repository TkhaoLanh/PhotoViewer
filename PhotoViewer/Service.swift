//
//  Service.swift
//  PhotoViewer
//
//  Created by user248619 on 10/10/23.
//

import Foundation

class Service{
    private init(){}
    static var shared = Service()
    
    func getImage(urlStr : String, completion : @escaping (Data?) -> ()){
        guard let url = URL(string: urlStr) else {return}
        
        let myQ = DispatchQueue(label: "myQ")
        myQ.async {
            let data = try? Data(contentsOf: url)
            completion(data)
        }
    }
    
    
}
