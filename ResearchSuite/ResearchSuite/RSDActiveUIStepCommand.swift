//
//  RSDActiveUIStepCommand.swift
//  ResearchSuite
//
//  Copyright © 2017 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation

public struct RSDActiveUIStepCommand : RSDStringLiteralOptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ unionSet: RSDActiveUIStepCommand, codingKey: String) {
        self.rawValue = unionSet.rawValue

        type(of: self).set(rawValue: unionSet.rawValue, forKey: codingKey)
    }
    
    public init(from decoder: Decoder) throws {
        // Register the commands included in the base struct to add them to the mapping
        let _: RSDActiveUIStepCommand = [.playSound,
                                         .vibrate,
                                         .transitionAutomatically]
        
        // Then call the initializer with the string mappings
        try self.init(from: decoder, stringMapping: RSDActiveUIStepCommand.stringMapping)
    }
    
    /// A mapping of an option to a string value
    public private(set) static var stringMapping: [String : Int] = [:]
    
    public static func set(rawValue: RawValue, forKey: String) {
        stringMapping[forKey] = rawValue
    }

    /**
     Play a default sound when the step starts.
     */
    public static let playSoundOnStart = RSDActiveUIStepCommand(1 << 0, codingKey: "playSoundOnStart")
    
    /**
     Play a default sound when the step finishes.
     */
    public static let playSoundOnFinish = RSDActiveUIStepCommand(1 << 1, codingKey: "playSoundOnFinish")
    
    /**
     Play a default sound when the step starts and finishes.
     */
    public static let playSound = RSDActiveUIStepCommand([.playSoundOnStart, .playSoundOnFinish], codingKey: "playSound")
    
    /**
     Vibrate when the step starts.
     */
    public static let vibrateOnStart = RSDActiveUIStepCommand(1 << 2, codingKey: "vibrateOnStart")
    
    /**
     Vibrate when the step finishes.
     */
    public static let vibrateOnFinish = RSDActiveUIStepCommand(1 << 3, codingKey: "vibrateOnFinish")
    
    /**
     Vibrate when the step starts and finishes.
     */
    public static let vibrate = RSDActiveUIStepCommand([.vibrateOnStart, .vibrateOnFinish], codingKey: "vibrate")
    
    /**
     Start the count down timer automatically when the step start.
     */
    public static let startTimerAutomatically = RSDActiveUIStepCommand(1 << 4, codingKey: "startTimerAutomatically")
    
    /**
     Transition automatically when the step finishes.
     */
    public static let continueOnFinish = RSDActiveUIStepCommand(1 << 5, codingKey: "continueOnFinish")
    
    /**
     Start the count down timer automatically when the step starts and transition automatically when the step finishes.
     */
    public static let transitionAutomatically = RSDActiveUIStepCommand([.startTimerAutomatically, .continueOnFinish], codingKey: "transitionAutomatically")
    
    /**
     The default commands for a step.
     */
    public static let defaultCommands: RSDActiveUIStepCommand = []
}



