//
//  Counted.swift
//  Pods
//
//  Created by John Morgan on 29/04/2016.
//
//

public enum Counted<Element> {
    
    public typealias E = Element
    
    case N0
    case N1(E)
    case N2(E, E)
    case N3(E, E, E)
    case N4(E, E, E, E)
    case N5(E, E, E, E, E)
    case N6(E, E, E, E, E, E)
    case N7(E, E, E, E, E, E, E)
    case N8(E, E, E, E, E, E, E, E)
    case N9(E, E, E, E, E, E, E, E, E)
    case N10(E, E, E, E, E, E, E, E, E, E)
    
    indirect case N10Plus(E, E, E, E, E, E, E, E, E, E, Counted<E>)
    
    public init(_ elements: [Element]) {
        
        let e = elements
        
        switch e.count {    
        case 0:
            self = .N0
        case 1:
            self = .N1(e[0])
        case 2:
            self = .N2(e[0], e[1])
        case 3:
            self = .N3(e[0], e[1], e[2])
        case 4:
            self = .N4(e[0], e[1], e[2], e[3])
        case 5:
            self = .N5(e[0], e[1], e[2], e[3], e[4])
        case 6:
            self = .N6(e[0], e[1], e[2], e[3], e[4], e[5])
        case 7:
            self = .N7(e[0], e[1], e[2], e[3], e[4], e[5], e[6])
        case 8:
            self = .N8(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7])
        case 9:
            self = .N9(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8])
        case 10:
            self = .N10(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8], e[9])
        default:
            self = .N10Plus(e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8], e[9], Counted(Array(e[10..<elements.endIndex])))
        }
    }
    
    public init(elements: Element...) {
        
        self.init(elements)
    }
    
    public init<S: SequenceType where S.Generator.Element == Element>(sequence: S) {
        
        self.init(Array(sequence))
    }
    
    public var elements: [Element] {
        
        switch self {
        case .N0:
            return []
        case let .N1(e1):
            return [e1]
        case let .N2(e1, e2):
            return [e1, e2]
        case let .N3(e1, e2, e3):
            return [e1, e2, e3]
        case let .N4(e1, e2, e3, e4):
            return [e1, e2, e3, e4]
        case let .N5(e1, e2, e3, e4, e5):
            return [e1, e2, e3, e4, e5]
        case let .N6(e1, e2, e3, e4, e5, e6):
            return [e1, e2, e3, e4, e5, e6]
        case let .N7(e1, e2, e3, e4, e5, e6, e7):
            return [e1, e2, e3, e4, e5, e6, e7]
        case let .N8(e1, e2, e3, e4, e5, e6, e7, e8):
            return [e1, e2, e3, e4, e5, e6, e7, e8]
        case let .N9(e1, e2, e3, e4, e5, e6, e7, e8, e9):
            return [e1, e2, e3, e4, e5, e6, e7, e8, e9]
        case let .N10(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10):
            return [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10]
        case let .N10Plus(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, remainder):
            return [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10] + remainder.elements
        }
    }
    
    public mutating func append(x: Element) {
        
        self = Counted(elements + [x])
    }
    
    public mutating func removeLast() -> Element? {
        
        switch self {
        case .N0: return nil
        default:
            var elements = self.elements
            let popped = elements.removeLast()
            self = Counted(elements)
            return popped
        }
    }
    
    public mutating func removeFirst() -> Element? {
        
        switch self {
        case .N0: return nil
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

extension Counted: SequenceType {
    
    public func generate() -> AnyGenerator<Element> {
        
        var current = self
        return AnyGenerator {
            current.removeFirst()
        }
    }
}

extension Counted: ArrayLiteralConvertible {
    
    public init(arrayLiteral elements: Element...) {
        
        self.init(elements)
    }
}
