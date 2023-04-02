//
//  DynamicIsLandAndLiveActivityWidgetLiveActivity.swift
//  DynamicIsLandAndLiveActivityWidget
//
//  Created by Malli on 03/04/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIsLandAndLiveActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIsLandAndLiveActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIsLandAndLiveActivityAppAttributes.self) { context in
            LockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    dynamicIslandExpandedLeadingView(context: context)
                 }
                 
                 DynamicIslandExpandedRegion(.trailing) {
                     dynamicIslandExpandedTrailingView(context: context)
                 }
                 
                 DynamicIslandExpandedRegion(.center) {
                     dynamicIslandExpandedCenterView(context: context)
                 }
                 
                DynamicIslandExpandedRegion(.bottom) {
                    dynamicIslandExpandedBottomView(context: context)
                }
                
              } compactLeading: {
                  compactLeadingView(context: context)
              } compactTrailing: {
                  compactTrailingView(context: context)
              } minimal: {
                  minimalView(context: context)
              }
              .keylineTint(.cyan)
        }
    }
    
    
    //MARK: Expanded Views
    func dynamicIslandExpandedLeadingView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        VStack {
            Label {
                Text("\(context.attributes.numberOfGroceyItems)")
                    .font(.title2)
            } icon: {
                Image("grocery")
                    .foregroundColor(.green)
            }
            Text("items")
                .font(.title2)
        }
    }
    
    func dynamicIslandExpandedTrailingView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        Label {
            Text(context.state.deliveryTime, style: .timer)
                .multilineTextAlignment(.trailing)
                .frame(width: 50)
                .monospacedDigit()
        } icon: {
            Image(systemName: "timer")
                .foregroundColor(.green)
        }
        .font(.title2)
    }
    
    func dynamicIslandExpandedBottomView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        let url = URL(string: "LiveActivities://?CourierNumber=87987")
        return Link(destination: url!) {
            Label("Call courier", systemImage: "phone")
        }.foregroundColor(.green)
    }
    
    func dynamicIslandExpandedCenterView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        Text("\(context.state.courierName) is on the way!")
            .lineLimit(1)
            .font(.caption)
    }
    
    
    //MARK: Compact Views
    func compactLeadingView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        VStack {
            Label {
                Text("\(context.attributes.numberOfGroceyItems) items")
            } icon: {
                Image("grocery")
                    .foregroundColor(.green)
            }
            .font(.caption2)
        }
    }
    
    func compactTrailingView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        Text(context.state.deliveryTime, style: .timer)
            .multilineTextAlignment(.center)
            .frame(width: 40)
            .font(.caption2)
    }
    
    func minimalView(context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>) -> some View {
        VStack(alignment: .center) {
            Image(systemName: "timer")
            Text(context.state.deliveryTime, style: .timer)
                .multilineTextAlignment(.center)
                .monospacedDigit()
                .font(.caption2)
        }
    }
}





@available(iOSApplicationExtension 16.1, *)
struct LockScreenView: View {
    var context: ActivityViewContext<DynamicIsLandAndLiveActivityAppAttributes>
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .center) {
                    Text(context.state.courierName + " is on the way!").font(.headline)
                    Text("You ordered \(context.attributes.numberOfGroceyItems) grocery items.")
                        .font(.subheadline)
                    BottomLineView(time: context.state.deliveryTime)
                }
            }
        }.padding(15)
    }
}

struct BottomLineView: View {
    var time: Date
    var body: some View {
        HStack {
            Divider().frame(width: 50,
                            height: 10)
            .overlay(.gray).cornerRadius(5)
            Image("delivery")
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(style: StrokeStyle(lineWidth: 1,
                                               dash: [4]))
                    .frame(height: 10)
                    .overlay(Text(time, style: .timer).font(.system(size: 8)).multilineTextAlignment(.center))
            }
            Image("home-address")
        }
    }
}
