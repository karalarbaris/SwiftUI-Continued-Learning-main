//
//  TimerB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 16.08.23.
//

import SwiftUI

struct TimerB: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
     @State var currentDate: Date = Date()
     
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     //        formatter.dateStyle = .medium
     return formatter
     }
     */
    
    // Countdown
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
     @State var timeRemaining: String = ""
     
     let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining() {
     let remaining = Calendar.current.dateComponents([.hour, .minute, .second ], from: Date(), to: futureDate)
     let hour = remaining.hour ?? 0
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timeRemaining = "\(hour):\(minute):\(second)"
     }
     */
    
    // Animation counter
    
    @State var count: Int = 1
    
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            //            Text(timeRemaining)
            //                .font(.system(size: 100, weight: .semibold, design: .rounded))
            //                .foregroundColor(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
            //            HStack(spacing:15) {
            //                Circle()
            //                    .offset(y: count == 1 ? -20 : 0)
            //                Circle()
            //                    .offset(y: count == 2 ? -20 : 0)
            //                Circle()
            //                    .offset(y: count == 3 ? -20 : 0)
            //            }
            //            .frame(width: 150)
            //            .foregroundColor(.white)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
            }
            .frame(height: 200)
            .tabViewStyle(.page)
            
            
        }
        
        //        .onReceive(timer) { value in
        //            currentDate = value
        //        }
        
        //        .onReceive(timer) { _ in
        //            if count <= 1 {
        //                finishedText = "wow"
        //            } else {
        //                count -= 1
        //            }
        //        }
        
        //        .onReceive(timer) { _ in
        //            updateTimeRemaining()
        //        }
        
        //        .onReceive(timer) { _ in
        //            withAnimation(.easeInOut(duration: 0.5)) {
        //                count = count == 3 ? 0 : count + 1
        //            }
        //
        //        }
        
        .onReceive(timer) { _ in
            withAnimation {
                count = count == 4 ? 1 : count + 1
            }
        }
    }
}

struct TimerB_Previews: PreviewProvider {
    static var previews: some View {
        TimerB()
    }
}
