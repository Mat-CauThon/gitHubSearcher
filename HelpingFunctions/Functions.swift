//
//  Functions.swift
//  HelpingFunctions
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) -> () -> Void) -> () -> Void {
    return { [weak owner] in
        return owner.map { f($0)() } ?? ()
    }
}

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> (U) -> Void) -> (U) -> Void {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) } ?? ()
    }
}

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U, V) -> Void) -> (U, V) -> Void {
    return { [weak owner] obj1, obj2 in
        return owner.map { f($0)(obj1, obj2) } ?? ()
    }
}

public func weakify <T: AnyObject, U, V, W>(_ owner: T, _ f: @escaping (T) -> (U, V, W) -> Void) -> (U, V, W) -> Void {
    return { [weak owner] obj1, obj2, obj3 in
        return owner.map { f($0)(obj1, obj2, obj3) } ?? ()
    }
}

public func weakify <T: AnyObject, R>(_ owner: T, _ f: @escaping (T) -> () -> R) -> () -> R? {
    return { [weak owner] in
        return owner.map { f($0)() }
    }
}

public func weakify <T: AnyObject, U, R>(_ owner: T, _ f: @escaping (T) -> (U) -> R) -> (U) -> R? {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) }
    }
}

public func weakify <T: AnyObject, U, V, R>(_ owner: T, _ f: @escaping (T) -> (U, V) -> R) -> (U, V) -> R? {
    return { [weak owner] obj1, obj2 in
        return owner.map { f($0)(obj1, obj2) }
    }
}

public func weakify <T: AnyObject, U, V, W, R>(_ owner: T, _ f: @escaping (T) -> (U, V, W) -> R) -> (U, V, W) -> R? {
    return { [weak owner] obj1, obj2, obj3 in
        return owner.map { f($0)(obj1, obj2, obj3) }
    }
}

public func weakify <T: AnyObject, R>(_ owner: T, _ f: @escaping (T) -> () -> Optional<R>) -> () -> R? {
    return { [weak owner] in
        return owner.flatMap { f($0)() }
    }
}

public func weakify <T: AnyObject, U, R>(_ owner: T, _ f: @escaping (T) -> (U) -> Optional<R>) -> (U) -> R? {
    return { [weak owner] obj in
        return owner.flatMap { f($0)(obj) }
    }
}

public func weakify <T: AnyObject, U, V, R>(_ owner: T, _ f: @escaping (T) -> (U, V) -> Optional<R>) -> (U, V) -> R? {
    return { [weak owner] obj1, obj2 in
        return owner.flatMap { f($0)(obj1, obj2) }
    }
}

public func weakify <T: AnyObject, U, V, W, R>(_ owner: T, _ f: @escaping (T) -> (U, V, W) -> Optional<R>) -> (U, V, W) -> R? {
    return { [weak owner] obj1, obj2, obj3 in
        return owner.flatMap { f($0)(obj1, obj2, obj3) }
    }
}
