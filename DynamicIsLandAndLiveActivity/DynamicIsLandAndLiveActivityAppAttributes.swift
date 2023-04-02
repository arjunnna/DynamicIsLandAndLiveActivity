//
//  DynamicIsLandAndLiveActivityAppAttributes.swift
//  DynamicIsLandAndLiveActivity
//
//  Created by Malli on 03/04/23.
//

import Foundation
import ActivityKit

struct DynamicIsLandAndLiveActivityAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {
        var courierName: String
        var deliveryTime: Date
    }
    var numberOfGroceyItems: Int
    var id = UUID()
}

