//
//  Nexus.swift
//  FirebladeECS
//
//  Created by Christian Treffs on 09.10.17.
//

/// entity id ^ component identifier hash
public typealias EntityComponentHash = Int
public typealias ComponentIdsByEntityIndex = Int
public typealias ComponentTypeHash = Int // component object identifier hash value
public typealias UniformComponents = ManagedContiguousArray<Component>
public typealias UniformEntityIdentifiers = UnorderedSparseSet<EntityIdentifier>
public typealias ComponentIdentifiers = ContiguousArray<ComponentIdentifier>
public typealias ComponentSet = Set<ComponentIdentifier>
public typealias Entities = UnorderedSparseSet<Entity>
public typealias EntityIdSet = Set<EntityIdentifier>
public typealias FamilyTraitSetHash = Int
public typealias TraitEntityIdHash = Int
public typealias EntityIdInFamilyIndex = Int
public typealias TraitEntityIdHashSet = [TraitEntityIdHash: EntityIdInFamilyIndex]
public typealias SparseComponentIdentifierSet = UnorderedSparseSet<ComponentIdentifier>

public protocol NexusDelegate: class {
	func nexusEventOccurred(_ event: ECSEvent)
	func nexusRecoverableErrorOccurred(_ message: String)
}

public class Nexus: Equatable {

	weak var delegate: NexusDelegate?

	/// - Index: index value matching entity identifier shifted to Int
	/// - Value: each element is a entity instance
	var entityStorage: Entities

	/// - Key: component type identifier
	/// - Value: each element is a component instance of the same type (uniform). New component instances are appended.
	var componentsByType: [ComponentIdentifier: UniformComponents]

	/// - Key: entity id as index
	/// - Value: each element is a component identifier associated with this entity
	var componentIdsByEntity: [EntityIndex: SparseComponentIdentifierSet]

	/// - Values: entity ids that are currently not used
	var freeEntities: ContiguousArray<EntityIdentifier>

	//var familiesByTraitHash: [FamilyTraitSetHash: Family]
	var familyMembersByTraits: [FamilyTraitSet: UniformEntityIdentifiers]

	public init() {
		entityStorage = Entities()
		componentsByType = [:]
		componentIdsByEntity = [:]
		freeEntities = ContiguousArray<EntityIdentifier>()
		familyMembersByTraits = [:]
	}

    public final func clear() {
        for entity: Entity in entityStorage {
            destroy(entity: entity)
        }

        entityStorage.clear()
        freeEntities.removeAll()

        assert(entityStorage.isEmpty)
        assert(componentsByType.values.reduce(0) { $0 + $1.count } == 0)
        assert(componentIdsByEntity.values.reduce(0) { $0 + $1.count } == 0)
        assert(freeEntities.isEmpty)
        assert(familyMembersByTraits.values.reduce(0) { $0 + $1.count } == 0)

        componentsByType.removeAll()
        componentIdsByEntity.removeAll()
        familyMembersByTraits.removeAll()
    }

	deinit {
        clear()
	}

    // MARK: Equatable
    public static func == (lhs: Nexus, rhs: Nexus) -> Bool {
        return lhs.entityStorage == rhs.entityStorage &&
        lhs.componentIdsByEntity == rhs.componentIdsByEntity &&
        lhs.freeEntities == rhs.freeEntities &&
        lhs.familyMembersByTraits == rhs.familyMembersByTraits
        // TODO: components are not equatable yet
        //lhs.componentsByType == rhs.componentsByType
    }
}

// MARK: - nexus delegate
extension Nexus {

	func notify(_ event: ECSEvent) {
		delegate?.nexusEventOccurred(event)
	}

	func report(_ message: String) {
		delegate?.nexusRecoverableErrorOccurred(message)
	}
}
