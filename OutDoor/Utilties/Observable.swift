//
//  Observable.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation

/**
 Protocol describing an object which may be observed by associated observers.

 The observable weakly references its observers.
 */
protocol Observable: class {

    /**
     Type of observer: which will be a protocol defining the notifications that may be sent.
     */
    associatedtype Observer

    /**
     Adds an observer.
     */
    func addObserver(_ observer: Observer)

    /**
     Removes an observer.
     */
    func removeObserver(_ observer: Observer)

    /**
     Notifies all observers with the specified closure.
     */
    func notifyObservers(_ closure: (Observer) -> Void)

}

/**
 Wrapper around an object reference to prevent it being strongly retained.
 */
public final class WeakReference<T>: NSObject {

    /**
     Target object, which may be nil if deallocated.
     */
    public var target: T? {
        return _targetObj as? T
    }

    /**
     Internal weak reference.
     */
    private weak var _targetObj: AnyObject?

    /**
     Internal storage of memory address.
     */
    private let _memoryAddress: Int

    public init(_ target: T) {
        self._memoryAddress = unsafeBitCast(target as AnyObject, to: Int.self)
        self._targetObj = target as AnyObject
        super.init()
    }

    public override var hash: Int {
        return _memoryAddress
    }

    public override func isEqual(_ object: Any?) -> Bool {
        if let ref = object as? WeakReference {
            return self._memoryAddress == ref._memoryAddress
        }
        return self._memoryAddress == unsafeBitCast(object as AnyObject, to: Int.self)
    }

}

private struct AssociatedKeys {
    static var observers = "Observable.AssociatedKeys.observers"
}

extension Observable {

    private var observers: [WeakReference<Observer>] {
        get {
            return associatedValue(for: self, key: &AssociatedKeys.observers, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC, defaultValue: [WeakReference<Observer>]())
        }
        set(newObservers) {
            objc_setAssociatedObject(self, &AssociatedKeys.observers, newObservers, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addObserver(_ observer: Observer) {
        
        observers.append(WeakReference(observer))
    }

    func removeObserver(_ observer: Observer) {
        observers = observers.filter({ !$0.isEqual(observer) })
    }

    func notifyObservers(_ closure: (Observer) -> Void) {
        observers.forEach({ closure($0.target!) })
    }

}
