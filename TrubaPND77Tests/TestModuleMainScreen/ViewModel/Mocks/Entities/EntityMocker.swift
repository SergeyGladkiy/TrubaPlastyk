//
//  EntityMocker.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMocker {
    static func wrongNumberOfItemsInDataBase() -> Int {
        return 4
    }
    
    static func generateItem() -> [Int: ItemMainScreen] {
        return [1: ItemMainScreen(group: 1,
                                  groupName: "Производители труб",
                              description: "Вы можете найти трубу по бренду", attachments: [AttachmentItemMainScreen(imageName: "photo", attachmentTitle: "HYDRO")])]
    }
    
    
}
