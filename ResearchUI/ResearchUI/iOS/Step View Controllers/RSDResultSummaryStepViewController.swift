//
//  RSDResultSummaryStepViewController.swift
//  ResearchUI (iOS)
//
//  Copyright © 2018 Sage Bionetworks. All rights reserved.
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

import UIKit
import Research

open class RSDResultSummaryStepViewController: RSDStepViewController {

    @IBOutlet public var resultLabel: UILabel?
    @IBOutlet public var unitLabel: UILabel?
    
    open override var stepViewModel: RSDStepViewPathComponent! {
        get {
            return super.stepViewModel
        }
        set {
            super.stepViewModel = (newValue is RSDResultSummaryStepViewModel) ? newValue :
                self.instantiateStepViewModel(for: newValue.step, with: newValue.parent)
        }
    }
    
    /// Override the default behavior to instantiate a result summary step view model.
    override open func instantiateStepViewModel(for step: RSDStep, with parent: RSDPathComponent?) -> RSDStepViewPathComponent {
        return RSDResultSummaryStepViewModel(step: step, parent: parent)
    }
    
    /// Override to set the unit and result text.
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.resultLabel?.text = self.resultText
        self.unitLabel?.text = self.unitText
    }
    
    /// Override to post accessibility announcement.
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        postAccessibilityAnnouncement()
    }
    
    /// The data source for view controller.
    open var resultData: RSDResultSummaryStepViewModel? {
        return self.stepViewModel as? RSDResultSummaryStepViewModel
    }
    
    /// The result text to display.
    open var resultText: String? {
        return self.resultData?.resultText
    }
    
    /// The unit text to display.
    open var unitText: String? {
        return self.resultData?.unitText
    }

    func postAccessibilityAnnouncement() {
        var announcement: String = ""
        if let title = self.stepTitleLabel?.text {
            announcement.append(title)
        }
        if let text = self.stepTextLabel?.text {
            announcement.append(" ")
            announcement.append(text)
        }
        if let result = self.resultText {
            announcement.append(" ")
            announcement.append(result)
        }
        if let unit = self.unitText {
            announcement.append(" ")
            announcement.append(unit)
        }
        let message = announcement.trimmingCharacters(in: .whitespaces)
        
        if message.count > 0 {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
}
