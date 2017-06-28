//
//  NewsCache+CoreDataProperties.swift
//  
//
//  Created by Seven on 2017/6/28.
//
//

import Foundation
import CoreData


extension NewsCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsCache> {
        return NSFetchRequest<NewsCache>(entityName: "NewsCache")
    }


}
