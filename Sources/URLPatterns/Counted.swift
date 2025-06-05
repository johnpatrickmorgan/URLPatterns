//
//  Counted.swift
//  Pods
//
//  Created by John Morgan on 29/04/2016.
//
//

public enum Counted<Element> {
    
    public typealias E = Element
    
    case n0
    case n1(E)
    case n2(E, E)
    case n3(E, E, E)
    case n4(E, E, E, E)
    case n5(E, E, E, E, E)
    case n6(E, E, E, E, E, E)
    case n7(E, E, E, E, E, E, E)
    case n8(E, E, E, E, E, E, E, E)
    case n9(E, E, E, E, E, E, E, E, E)
    
    indirect case n10(E, E, E, E, E, E, E, E, E, E, plus: Counted<E>)
    
    public init(_ elements: [Element]) {
        
        let e = elements
        
        switch e.count {    
        case 0:
            self = .n0
        case 1:
            self = .n1(e[0])
        case 2:
            self = .n2(e[0], e[1])
        case 3:
            self = .n3(e[0], e[1], e[2])
        case 4:
            self = .n4(e[0], e[1], e[2], e[3])
        case 5:
            self = .n5(e[0], e[1], e[2], e[3], e[4])
        case 6:
            self = .n6(e[0], e[1], e[2], e[3], e[4], e[5])
        case 7:
            self = .n7(e[0], e[1], e[2], e[3], e[4], e[5], e[6])
        case 8:
            self = .n8(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7])
        case 9:
            self = .n9(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8])
        default:
            self = .n10(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8], e[9], plus: Counted(Array(e[elements.indices.suffix(from: 10)])))
        }
    }
    
    public init(elements: Element...) {
        
        self.init(elements)
    }
    
    public init<S: Sequence>(sequence: S) where S.Iterator.Element == Element {
        
        self.init(Array(sequence))
    }
    
    public var elements: [Element] {
        
        switch self {
        case .n0:
            return []
        case let .n1(e1):
            return [e1]
        case let .n2(e1, e2):
            return [e1, e2]
        case let .n3(e1, e2, e3):
            return [e1, e2, e3]
        case let .n4(e1, e2, e3, e4):
            return [e1, e2, e3, e4]
        case let .n5(e1, e2, e3, e4, e5):
            return [e1, e2, e3, e4, e5]
        case let .n6(e1, e2, e3, e4, e5, e6):
            return [e1, e2, e3, e4, e5, e6]
        case let .n7(e1, e2, e3, e4, e5, e6, e7):
            return [e1, e2, e3, e4, e5, e6, e7]
        case let .n8(e1, e2, e3, e4, e5, e6, e7, e8):
            return [e1, e2, e3, e4, e5, e6, e7, e8]
        case let .n9(e1, e2, e3, e4, e5, e6, e7, e8, e9):
            return [e1, e2, e3, e4, e5, e6, e7, e8, e9]
        case let .n10(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, remainder):
            return [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10] + remainder.elements
        }
    }
    
    public mutating func append(_ x: Element) {
        
        self = Counted(elements + [x])
    }
    
    public mutating func removeLast() -> Element? {
        
        switch self {
        case .n0: return nil
        default:
            var elements = self.elements
            let popped = elements.removeLast()
            self = Counted(elements)
            return popped
        }
    }
    
    public mutating func removeFirst() -> Element? {
        
        switch self {
        case .n0: return nil
        default:
            var elements = self.elements
            let popped = elements.removeFirst()
            self = Counted(elements)
            return popped
        }
    }
    
    public subscript(index: Int) -> Element {
        
        return elements[index]
    }
}

extension Counted: Sequence {
    
    public func makeIterator() -> AnyIterator<Element> {
        
        var current = self
        return AnyIterator {
            current.removeFirst()
        }
    }
}

extension Counted: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        
        self.init(elements)
    }
}

extension Counted: Equatable where Element: Equatable {
    
    public static func == (lhs: Counted, rhs: Counted) -> Bool {
        return lhs.elements == rhs.elements
    }
}

extension Counted: Sendable where Element: Sendable {}
