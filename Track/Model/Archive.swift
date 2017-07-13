//
//  Archive.swift
//  Track
//
//  Created by ty on on 6/22/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import Foundation
class Archive {
    var id: String!
    var logs: [Log]!
    init(log: [Log]) {
        self.logs = log
    }
}
