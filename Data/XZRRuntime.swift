//
//  XZRRuntime.swift
//  Data
//
//  Created by 许正荣 on 2017/5/22.
//  Copyright © 2017年 许正荣. All rights reserved.
//

import Foundation



func methodSwizNonThreadSafe(_ cls: Swift.AnyClass!, _ srcSelector: Selector!, _ dstSelector: Selector!) {
    var srcMethod = class_getClassMethod(cls, srcSelector);
    var dstMethod: Method? = nil;
    if (srcMethod != nil) {
        dstMethod = class_getClassMethod(cls, dstSelector);
        if (!(dstMethod != nil)) {
            return;
        }
    } else {
        srcMethod = class_getInstanceMethod(cls, srcSelector);
        if (srcMethod != nil) {
            dstMethod = class_getInstanceMethod(cls, dstSelector);
            if (!(dstMethod != nil)) {
                return;
            }
        }
    }

    if (class_addMethod(cls, srcSelector, method_getImplementation(dstMethod), method_getTypeEncoding(dstMethod))) {
        class_replaceMethod(cls, dstSelector, method_getImplementation(srcMethod), method_getTypeEncoding(srcMethod));
    } else {
        method_exchangeImplementations(srcMethod, dstMethod);
    }


}


func methodSwizThreadSafe(_ cls: Swift.AnyClass!, _ srcSelector: Selector!, _ dstSelector: Selector!) {
    DispatchQueue.once(token: "DXRuntimeSwizzing") {
        methodSwizNonThreadSafe(cls, srcSelector, dstSelector)
    };
}


public extension DispatchQueue {
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
