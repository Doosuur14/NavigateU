//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if canImport(UIKit)
    import UIKit
#else
    import AppKit
#endif


public extension ConstraintView {
    
    @available(*, deprecated, renamed:"snp.left")
    var snpLeft: ConstraintItem { return self.snp.left }

    @available(*, deprecated, renamed:"snp.top")
    var snpTop: ConstraintItem { return self.snp.top }

    @available(*, deprecated, renamed:"snp.right")
    var snpRight: ConstraintItem { return self.snp.right }

    @available(*, deprecated, renamed:"snp.bottom")
    var snpBottom: ConstraintItem { return self.snp.bottom }

    @available(*, deprecated, renamed:"snp.leading")
    var snpLeading: ConstraintItem { return self.snp.leading }

    @available(*, deprecated, renamed:"snp.trailing")
    var snpTrailing: ConstraintItem { return self.snp.trailing }

    @available(*, deprecated, renamed:"snp.width")
    var snpWidth: ConstraintItem { return self.snp.width }

    @available(*, deprecated, renamed:"snp.height")
    var snpHeight: ConstraintItem { return self.snp.height }

    @available(*, deprecated, renamed:"snp.centerX")
    var snpCenterX: ConstraintItem { return self.snp.centerX }

    @available(*, deprecated, renamed:"snp.centerY")
    var snpCenterY: ConstraintItem { return self.snp.centerY }

    @available(*, deprecated, renamed:"snp.baseline")
    var snpBaseline: ConstraintItem { return self.snp.baseline }

    @available(*, deprecated, renamed:"snp.lastBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var snpLastBaseline: ConstraintItem { return self.snp.lastBaseline }

    @available(iOS, deprecated, renamed:"snp.firstBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var snpFirstBaseline: ConstraintItem { return self.snp.firstBaseline }

    @available(iOS, deprecated, renamed:"snp.leftMargin")
    @available(iOS 8.0, *)
    var snpLeftMargin: ConstraintItem { return self.snp.leftMargin }

    @available(iOS, deprecated, renamed:"snp.topMargin")
    @available(iOS 8.0, *)
    var snpTopMargin: ConstraintItem { return self.snp.topMargin }

    @available(iOS, deprecated, renamed:"snp.rightMargin")
    @available(iOS 8.0, *)
    var snpRightMargin: ConstraintItem { return self.snp.rightMargin }

    @available(iOS, deprecated, renamed:"snp.bottomMargin")
    @available(iOS 8.0, *)
    var snpBottomMargin: ConstraintItem { return self.snp.bottomMargin }

    @available(iOS, deprecated, renamed:"snp.leadingMargin")
    @available(iOS 8.0, *)
    var snpLeadingMargin: ConstraintItem { return self.snp.leadingMargin }

    @available(iOS, deprecated, renamed:"snp.trailingMargin")
    @available(iOS 8.0, *)
    var snpTrailingMargin: ConstraintItem { return self.snp.trailingMargin }

    @available(iOS, deprecated, renamed:"snp.centerXWithinMargins")
    @available(iOS 8.0, *)
    var snpCenterXWithinMargins: ConstraintItem { return self.snp.centerXWithinMargins }
    
    @available(iOS, deprecated, renamed:"snp.centerYWithinMargins")
    @available(iOS 8.0, *)
    var snpCenterYWithinMargins: ConstraintItem { return self.snp.centerYWithinMargins }

    @available(*, deprecated, renamed:"snp.edges")
    var snpEdges: ConstraintItem { return self.snp.edges }

    @available(*, deprecated, renamed:"snp.size")
    var snpSize: ConstraintItem { return self.snp.size }

    @available(*, deprecated, renamed:"snp.center")
    var snpCenter: ConstraintItem { return self.snp.center }

    @available(iOS, deprecated, renamed:"snp.margins")
    @available(iOS 8.0, *)
    var snpMargins: ConstraintItem { return self.snp.margins }

    @available(iOS, deprecated, renamed:"snp.centerWithinMargins")
    @available(iOS 8.0, *)
    var snpCenterWithinMargins: ConstraintItem { return self.snp.centerWithinMargins }

    @available(*, deprecated, renamed:"snp.prepareConstraints(_:)")
    func snpPrepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        return self.snp.prepareConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snp.makeConstraints(_:)")
    func snpMakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.makeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snp.remakeConstraints(_:)")
    func snpRemakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.remakeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snp.updateConstraints(_:)")
    func snpUpdateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.updateConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snp.removeConstraints()")
    func snpRemoveConstraints() {
        self.snp.removeConstraints()
    }
    
    var snp: ConstraintViewDSL {
        return ConstraintViewDSL(view: self)
    }
    
}
