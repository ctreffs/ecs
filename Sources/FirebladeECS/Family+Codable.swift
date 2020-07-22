//
//  Family+Codable.swift
//
//
//  Created by Christian Treffs on 22.07.20.
//

private struct FamilyMemberContainer<R> where R: FamilyRequirementsManaging {
    let components: [R.Components]
}

extension FamilyMemberContainer: Decodable where R: FamilyDecoding {
    init(from decoder: Decoder) throws {
        var familyContainer = try decoder.unkeyedContainer()
        let strategy = decoder.userInfo[.nexusCodingStrategy] as? CodingStrategy ?? DefaultCodingStrategy()
        self.components = try R.decode(componentsIn: &familyContainer, using: strategy)
    }
}

extension FamilyMemberContainer: Encodable where R: FamilyEncoding {
    func encode(to encoder: Encoder) throws {
        let strategy = encoder.userInfo[.nexusCodingStrategy] as? CodingStrategy ?? DefaultCodingStrategy()
        var familyContainer = encoder.unkeyedContainer()
        try R.encode(components: components, into: &familyContainer, using: strategy)
    }
}

// MARK: - encoding
public protocol TopLevelEncoder {
    /// The type this encoder produces.
    associatedtype Output

    /// Encodes an instance of the indicated type.
    ///
    /// - Parameter value: The instance to encode.
    func encode<T>(_ value: T) throws -> Self.Output where T: Encodable

    /// Contextual user-provided information for use during decoding.
    var userInfo: [CodingUserInfoKey: Any] { get set }
}

extension Family where R: FamilyEncoding {
    /// Encode family members (entities) to data using a given encoder.
    ///
    /// The encoded members will *NOT* be removed from the nexus and will also stay present in this family.
    /// - Parameter encoder: The data encoder. Data encoder respects the coding strategy set at `nexus.codingStrategy`.
    /// - Returns: The encoded data.
    public func encodeMembers<Encoder>(using encoder: inout Encoder) throws -> Encoder.Output where Encoder: TopLevelEncoder {
        encoder.userInfo[.nexusCodingStrategy] = nexus.codingStrategy
        let components: [R.Components] = self.map { $0 }
        let container = FamilyMemberContainer<R>(components: components)
        return try encoder.encode(container)
    }
}

// MARK: - decoding
public protocol TopLevelDecoder {
    /// The type this decoder accepts.
    associatedtype Input

    /// Decodes an instance of the indicated type.
    func decode<T>(_ type: T.Type, from: Self.Input) throws -> T where T: Decodable

    /// Contextual user-provided information for use during decoding.
    var userInfo: [CodingUserInfoKey: Any] { get set }
}

extension Family where R: FamilyDecoding {
    /// Decode family members (entities) from given data using a decoder.
    ///
    /// The decoded members will be added to the nexus and will be present in this family.
    /// - Parameters:
    ///   - data: The data decoded by decoder. A unkeyed container of family members (keyed component containers) is expected.
    ///   - decoder: The decoder to use for decoding family member data. Decoder respects the coding strategy set at `nexus.codingStrategy`.
    public func decodeMembers<Decoder>(from data: Decoder.Input, using decoder: inout Decoder) throws where Decoder: TopLevelDecoder {
        decoder.userInfo[.nexusCodingStrategy] = nexus.codingStrategy
        let familyMembers = try decoder.decode(FamilyMemberContainer<R>.self, from: data)
        for components in familyMembers.components {
            createMember(with: components)
        }
    }
}

extension CodingUserInfoKey {
    fileprivate static let nexusCodingStrategy = CodingUserInfoKey(rawValue: "nexusCodingStrategy")!
}

// MARK: - foundation
#if canImport(Foundation)
import class Foundation.JSONEncoder
import class Foundation.JSONDecoder

import class Foundation.PropertyListEncoder
import class Foundation.PropertyListDecoder

extension JSONEncoder: TopLevelEncoder { }
extension JSONDecoder: TopLevelDecoder { }

extension PropertyListEncoder: TopLevelEncoder { }
extension PropertyListDecoder: TopLevelDecoder { }
#endif
