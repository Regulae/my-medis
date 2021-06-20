//
//  ApplicationScheme.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import UIKit

class ApplicationScheme: NSObject{
    
    private static var singleton = ApplicationScheme()
    
    static var shared: ApplicationScheme{
        return singleton
    }
    
    public let colorscheme: MDCColorScheming = {
        
    }
}
